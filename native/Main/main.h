#ifndef MAIN_H
#define MAIN_H

#include <Godot.hpp>
#include <Node.hpp>

#include <RichTextLabel.hpp>
#include <Label.hpp>
#include <Button.hpp>
#include <FileDialog.hpp>

#include <TextureRect.hpp>
#include <ImageTexture.hpp>
#include <Image.hpp>

#include <Thread.hpp>

#include "emulatorController.h"


namespace Concept1
{
	using namespace godot;
	using namespace TheBoy;

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
		bool _running = false;

		/// @brief Select rom button
		Button *_selectBtn;
		/// @brief Line edit with the rom path
		Label *_romPath;
		FileDialog* _fileDialog;


		/// @brief Reference to the on Scene outTexture
		TextureRect *_outTextureRect;
		/// @brief Reference to the on Scene out vRam texture
		TextureRect *_vRamTextureRect;

		Vector2 tileSizeView = Vector2(24, 16);

		ImageTexture *_outTexture;
		ImageTexture *_outVRamTexture;

		/// @brief Internal output image
		Image *_outImage;
		/// @brief Internal vRam representation
		Image *_outVRamImage;
		/// @brief
		RichTextLabel *_textOut;

		Color gbPallet[4] = {
			Color().hex(0xFFFFFFFF),
			Color().hex(0xACACACFF),
			Color().hex(0x555555FF),
			Color().hex(0x000000FF)
		};

		/**
		 * @brief Pointer to the TheBoy EmulatorController object
		 */
		TheBoy::EmulatorController *_emulCtrl;

		Thread* _cpuThread;

		/// @brief On Ready gather nodes
		void OnReadyGets();
		void OnFileSelected(String newText);

		/// @brief Initial texture generation
		void GenerateTextures();
		/// @brief Builds the output string
		void BuildOutputString();
		/// @brief Builds the debug texture image
		void BuildDebugView();
		void addTileToDebug(bit16 addr, int tileId);

		void CpuStep();
	};

} // namespace Concept1
#endif