#ifndef MAIN_H
#define MAIN_H

#include <Godot.hpp>
#include <Node.hpp>

namespace Concept1 {
using namespace godot;

class Main : public Node {
    GODOT_CLASS(Main, Node) private : public : static void _register_methods();

    Main();
    ~Main() = default;

    void _init();
    void _ready();
};

}  // namespace Concept1
#endif