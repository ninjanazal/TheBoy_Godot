#include "main.h"

using namespace Concept1;

void Main::_register_methods() { register_method("_ready", &Main::_ready); }

Main::Main() {}
void Main::_init() {}

void Main::_ready() {
	Godot::print("Hello form the native side");
}
