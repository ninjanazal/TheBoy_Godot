#ifndef LOADMANAGER_H
#define LOADMANAGER_H

#include <godot.hpp>
#include <node.hpp>

namespace godot {
namespace VoxelSpace {

class LoadManager : public Node {
    GODOT_CLASS(LoadManager, Node)

   private:
    float time_passed;

   public:
    LoadManager();
    ~LoadManager();
};

}  // namespace VoxelSpace

}  // namespace godot

#endif