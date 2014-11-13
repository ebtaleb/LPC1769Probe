
#ifndef SPEAKER_H_
#define SPEAKER_H_

#include "LPC17xx.h"

// Function definitions
#define NOTE_PIN_HIGH() GPIO_SetValue(0, 1<<26);
#define NOTE_PIN_LOW()  GPIO_ClearValue(0, 1<<26);


#endif /* SPEAKER_H_ */
