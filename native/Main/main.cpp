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
	register_method("OnFileSelected", &Main::OnFileSelected);
}
void Main::_ready()
{
	_cpuThread = Thread::_new();
	OnReadyGets();
	_selectBtn->connect("pressed", _fileDialog, "popup_centered");
	_fileDialog->connect("file_selected", this, "OnFileSelected");
	GenerateTextures();
	_textOut->set_text(" - - - - - - - - - -");
	std::cout << _outVRamImage->get_size().width << std::endl;
}
void Main::_process(float delta)
{
	_textOut->set_text("|TheBoy - Game boy Emulator\n - - - - - - - - - - -\n|:: Cartrige Information");
	if (_running)
	{
		_emulCtrl->iteration(this);
		BuildOutputString();
		BuildDebugView();
		_outVRamTexture->create_from_image(_outVRamImage);
	}
}
void Main::OnReadyGets()
{
	_selectBtn = get_node<Button>("CanvasLayer/topBar/HBoxContainer/pathSelection/selectButton");
	_romPath = get_node<Label>("CanvasLayer/topBar/HBoxContainer/pathSelection/currentPath");
	_fileDialog = get_node<FileDialog>("CanvasLayer/FileDialog");

	_textOut = get_node<RichTextLabel>("body/RichTextLabel");
	_outTextureRect = get_node<TextureRect>("body/outputView");
	_vRamTextureRect = get_node<TextureRect>("body/vramView");
}
void Main::OnFileSelected(String newText)
{
	_romPath->set_text(newText);
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

void Main::BuildDebugView()
{
	std::cout << _outVRamImage->get_size().width << std::endl;

	/*
	Tile data is stored in VRAM in the memory area at $8000-$97FF;
	with each tile taking 16 bytes, this area defines data for 384 tiles
	Each tile has 8x8 pixels and has a color depth of 4 colors/gray shades
	384 = 16 * 24 disposal
*/
	_outVRamImage = Image::_new();
	_outVRamImage->create(static_cast<int64_t>(tileSizeView.x * 8),
						  static_cast<int64_t>(tileSizeView.y * 8), false, Image::FORMAT_RGB8);
	_outVRamImage->fill(Color());

	bit16 addr = 0x8000;
	// Making the display table
	// iGRam->create(tileSizeView.x * 8, tileSizeView.y * 8, sf::Color::White);
	for (unsigned int y = 0; y < tileSizeView.y; y++)
	{
		for (unsigned int x = 0; x < tileSizeView.x; x++)
		{
			addTileToDebug(addr, ((y * 24) + x));
		}
	}
	_outVRamTexture->create_from_image(_outVRamImage);
	_vRamTextureRect->set_texture(_outVRamTexture);
}

void Main::addTileToDebug(bit16 addr, int tileId)
{
	/*
			with each tile taking 16 bytes
			Each tile occupies 16 bytes, where each line is represented by 2 bytes
			For each line, the first byte specifies the least significant bit of the color ID of each pixel,
			and the second byte specifies the most significant bit. In both bytes, bit 7 represents the leftmost pixel,
			and bit 0 the rightmost.
		*/
	int yTileOff = static_cast<int>(floor(tileId / tileSizeView.x));
	int xTileOff = tileId - (yTileOff * tileSizeView.x);

	for (int t = 0; t < 16; t += 2)
	{
		// For each tile line, needs to be readed 2 bytes
		// High and Low tile line value
		bit8 byte1 = _emulCtrl->getBus()->abRead(addr + (tileId * 16) + t);
		bit8 byte2 = _emulCtrl->getBus()->abRead(addr + (tileId * 16) + t + 1);

		// for each bit on the gathered line, the low nib value is the most significat one and vice versa
		// Place the target bit value from the 1st byte on the left of the target bit from the 2st byte
		for (int b = 0; b < 8; b++)
		{
			bit8 pixelID = (GETBIT(byte1, b) << 1) | GETBIT(byte2, b);
			// Pixel ID makes the target pixel color value, for the gb is 1 of 4 colors
			// Since each pixel needs a 4 value entrance
			// 64 pixels per tile
			_outVRamImage->lock();
			_outVRamImage->set_pixel(
				(8 * xTileOff) + (7 - b),
				(8 * yTileOff) + static_cast<int>(floor(t / 2)),
				gbPallet[pixelID]);
			_outVRamImage->unlock();
		}
	}
}

void Main::CpuStep(){

}
