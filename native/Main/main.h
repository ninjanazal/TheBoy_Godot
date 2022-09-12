#ifndef MAIN_H
#define MAIN_H

#include <Godot.hpp>
#include <Node.hpp>
#include <LineEdit.hpp>
#include <TextureRect.hpp>
#include <ImageTexture.hpp>
#include <Image.hpp>

#include "emulatorController.h"

namespace Concept1
{
	using namespace godot;

	class Main : public Node
	{
	public:
		/**
		 * @brief Godot API for registing methods
		 */
		static void _register_methods();

		/**
		 * @brief Construct a new Main object
		 */
		Main();
		/**
		 * @brief Destroy the Main object
		 */
		~Main();

		void _init();
		void _ready();
		void _process(float delta);

	private:
		GODOT_CLASS(Main, Node);
		/// @brief Line edit with the rom path
		LineEdit* _romPath;
		
		/// @brief Reference to the on Scene outTexture
		TextureRect* _outTextureRect;
		/// @brief Reference to the on Scene out vRam texture
		TextureRect* _vRamTextureRect;

		Vector2 tileSizeView = Vector2(24, 16); 

		ImageTexture* _outTexture;
		ImageTexture* _outVRamTexture;

		/// @brief Internal output image
		Image* _outImage;
		/// @brief Internal vRam representation
		Image* _outVRamImage;

		/**
		 * @brief Pointer to the TheBoy EmulatorController object
		 */
		TheBoy::EmulatorController *emulCtrl;
		/// @brief On Ready gather nodes
		void OnReadyGets();

		void GenerateTextures();
	};

} // namespace Concept1
#endif