################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: demo_CKT_GPIO_Int.axf

# Tool invocations
demo_CKT_GPIO_Int.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MCU Linker'
	arm-none-eabi-gcc -nostdlib -L"/home/jmbto/workspace/Lib_CMSISv1p30_LPC17xx/Debug" -L"/home/jmbto/workspace/Lib_EaBaseBoard/Debug" -L"/home/jmbto/workspace/Lib_MCU/Debug" -Xlinker --gc-sections -Xlinker -Map=demo_CKT_GPIO_Int.map -mcpu=cortex-m3 -mthumb -T "rdb1768cmsis_uart_Debug.ld" -o "demo_CKT_GPIO_Int.axf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES) demo_CKT_GPIO_Int.axf
	-@echo ' '

post-build:
	-@echo 'Performing post-build steps'
	-arm-none-eabi-size demo_CKT_GPIO_Int.axf; # arm-none-eabi-objdump -h -S demo_CKT_GPIO_Int.axf >demo_CKT_GPIO_Int.lss
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY: post-build

-include ../makefile.targets
