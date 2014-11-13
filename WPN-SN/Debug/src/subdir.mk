################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cr_startup_lpc17.c \
../src/init_devices.c \
../src/int_handler.c \
../src/main.c \
../src/string_helpers.c \
../src/systick.c 

S_SRCS += \
../src/asm_variance.s 

OBJS += \
./src/asm_variance.o \
./src/cr_startup_lpc17.o \
./src/init_devices.o \
./src/int_handler.o \
./src/main.o \
./src/string_helpers.o \
./src/systick.o 

C_DEPS += \
./src/cr_startup_lpc17.d \
./src/init_devices.d \
./src/int_handler.d \
./src/main.d \
./src/string_helpers.d \
./src/systick.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU Assembler'
	arm-none-eabi-gcc -c -x assembler-with-cpp -DDEBUG -D__CODE_RED -D__NEWLIB__ -g3 -mcpu=cortex-m3 -mthumb -D__NEWLIB__ -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DDEBUG -D__USE_CMSIS=CMSISv1p30_LPC17xx -D__CODE_RED -D__NEWLIB__ -I"/home/jmbto/workspace/Lib_CMSISv1p30_LPC17xx/inc" -I"/home/jmbto/workspace/WPN-SN/src" -I"/home/jmbto/workspace/Lib_EaBaseBoard/inc" -I"/home/jmbto/workspace/Lib_MCU/inc" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -mcpu=cortex-m3 -mthumb -D__NEWLIB__ -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


