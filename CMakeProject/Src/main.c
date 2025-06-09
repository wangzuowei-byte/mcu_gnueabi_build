#include "main.h"
#include "stm32f4xx_hal.h"

//UART_HandleTypeDef huart1;

//void SystemClock_Config(void);
//static void MX_GPIO_Init(void);
//static void MX_USART1_UART_Init(void);
void _init(void) {}
void _fini(void) {}
int main(void) {
//    HAL_Init();
//    SystemClock_Config();
//    MX_GPIO_Init();
//    MX_USART1_UART_Init();

    char msg[] = "Hello from STM32\r\n";
    while (1) {
//        HAL_GPIO_TogglePin(GPIOG, GPIO_PIN_13);
//        HAL_UART_Transmit(&huart1, (uint8_t*)msg, sizeof(msg) - 1, HAL_MAX_DELAY);
//        HAL_Delay(1000);
    }
}
