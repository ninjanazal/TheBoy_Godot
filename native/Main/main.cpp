#include "main.h"

using namespace Concept1;

Main::Main()
{
	emulCtrl = new TheBoy::EmulatorController();
}
Main::~Main()
{
	delete emulCtrl;
}
void Main::_register_methods() { register_method("_ready", &Main::_ready); }

void Main::_init() {}

void Main::_ready()
{
	OnReadyGets();
}
void Main::OnReadyGets()
{
	_romPath = get_node<LineEdit>("CanvasLayer/topBar/HBoxContainer/pathSelection/currentPath");
}