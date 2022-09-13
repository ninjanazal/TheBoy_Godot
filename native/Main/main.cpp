#include "main.h"
#include "ppu.h"

using namespace Concept1;

Main::Main()
{
	_emulCtrl = new TheBoy::EmulatorController();
}
Main::~Main()
{
	delete _emulCtrl;
	delete _outTextureRect;
	delete _vRamTextureRect;
	delete _outTexture;
	delete _outVRamTexture;
	delete _outImage;
	delete _outVRamImage;
}
void Main::_init() {}

void Main::_register_methods()
{
	register_method("_ready", &Main::_ready);
	register_method("_process", &Main::_process);
	register_method("OnTextChanged", &Main::OnTextChanged);
}
void Main::_ready()
{
	OnReadyGets();
	_romPath->connect("text_entered", this, "OnTextChanged", {}, Object::CONNECT_ONESHOT);
	GenerateTextures();
	_textOut->set_text(" - - - - - - - - - -");
}
void Main::_process(float delta)
{
	_textOut->set_text("|TheBoy - Game boy Emulator\n - - - - - - - - - - -\n|:: Cartrige Information");
	if (_running)
	{
		BuildOutputString();
	}
}
void Main::OnReadyGets()
{
	_romPath = get_node<LineEdit>("CanvasLayer/topBar/HBoxContainer/pathSelection/currentPath");
	_textOut = get_node<RichTextLabel>("body/RichTextLabel");
	_outTextureRect = get_node<TextureRect>("body/outputView");
	_vRamTextureRect = get_node<TextureRect>("body/vramView");
}
void Main::OnTextChanged(String newText)
{
	_emulCtrl->Start(newText.alloc_c_string());
	_running = true;
}

void Main::GenerateTextures()
{
	_outTexture = ImageTexture::_new();
	_outVRamTexture = ImageTexture::_new();

	_outImage = Image::_new();
	_outVRamImage = Image::_new();

	_outImage->create(TheBoy::Ppu::xRes, TheBoy::Ppu::yRes, false, Image::FORMAT_RGB8);
	_outVRamImage->create(static_cast<int64_t>(tileSizeView.x * 8),
						  static_cast<int64_t>(tileSizeView.y * 8), false, Image::FORMAT_RGB8);

	_outImage->fill(Color());
	_outVRamImage->fill(Color());

	_outTexture->create_from_image(_outImage);
	_outVRamTexture->create_from_image(_outVRamImage);

	_outTextureRect->set_texture(_outTexture);
	_vRamTextureRect->set_texture(_outVRamTexture);
}

void Main::BuildOutputString()
{
	char *regBuffer(new char[256]{});
	char *opBuffer(new char[64]{});

	_emulCtrl->getCpu()->getCpuSummary(regBuffer, opBuffer);
	_textOut->add_text(regBuffer);
	_textOut->add_text("\n");
	_textOut->add_text(opBuffer);
}
