#include <modloader/loader.h>
#include <symbols.h>
#include "elf_helper.h"

using namespace modloader;

__attribute__((constructor))
static void modloader_init() {
    set_base_offset(ElfHelper::getCurrentModule());
    ModLoader::addLibSearchDir("mods");
    ModLoader::loadModsFromDirectory("mods");
}