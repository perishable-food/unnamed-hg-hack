#ifndef MEGA_H
#define MEGA_H

#include "types.h"

BOOL CheckCanMega(struct BattleStruct *battle, int client);
BOOL CheckCanDrawMegaButton(struct BI_PARAM *bip);
BOOL CheckIsMega(struct BI_PARAM *bip);
BOOL CheckIsPrimalGroudon(struct BI_PARAM *bip);
BOOL CheckIsPrimalKyogre(struct BI_PARAM *bip);
BOOL CheckCanMoveMegaEvolve(struct BattleStruct *sp, u32 client);
BOOL CheckCanSpeciesMegaEvolveByMove(struct BattleStruct *sp, u32 client);
BOOL IsMegaSpeciesByMove(u16 species);

#endif
