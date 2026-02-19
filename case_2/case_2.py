class Price:
    def __init__(self, name):
        self.name = name
        self.total_score = 0

    def add_component(self, price_data):
        score = price_data[1]
        self.total_score += score
        return score, price_data[0]

    def err(self):
        return f'{self.name} не в каталоге'


class Motherboard:
    def choose_motherboard(self):
        motherboard_input = input('Выберите сокет материнской платы из списка: (AM4, LGA1700). Ввод: ').upper()
        if motherboard_input == "AM4":
            return ["AM4", 4500]
        elif motherboard_input == "LGA1700":
            return ["LGA1700", 4750]
        else:
            return None

class CPU:
    def choose_cpu(self):
        CPU_input = input('Выберите процессор из списка: (R5, I5). Ввод: ').upper()
        if CPU_input == "R5":
            return ["R5", 2500]
        elif CPU_input == "I5":
            return ["I5", 1750]
        else:
            return None

class GPU:
    def choose_gpu(self):
        GPU_input = input('Выберите видеокарту из списка: (RX580, RTX2060). Ввод: ').upper()
        if GPU_input == "RX580":
            return ["RX580", 4900]
        elif GPU_input == "RTX2060":
            return ["RTX2060", 14750]
        else:
            return None

def start():
    price_calculator = Price("Calculator")

    while True:
        user_input = input('\nВас приветствует учебная программа по рассчету стоимости компьютерных комплектующих \n'
                           '(и демонстрации принципов работы базовых и производственных классов) в Python. \n'
                           'Введите компонент, который хотите добавить в сборку из списка: (GPU, CPU, Motherboard) \n'
                           'Или введите "EXIT" для выхода. \n'
                           'Ввод: ').upper()

        if user_input == "EXIT":
            print(f"\nИтоговая стоимость сборки: {price_calculator.total_score} руб.")
            break

        if user_input not in ['GPU', 'CPU', 'MOTHERBOARD']:
            result = price_calculator.err()
            print(result)
            continue

        elif user_input == 'MOTHERBOARD':
            motherboard = Motherboard()
            result = motherboard.choose_motherboard()
            if result is None:
                print("Неверный выбор материнской платы")
                continue

            score, name = price_calculator.add_component(result)
            print(f"Добавлена материнская плата {name} стоимостью {score} руб.")
            print(f"Текущая общая стоимость: {price_calculator.total_score} руб.")

        elif user_input == 'CPU':
            cpu_instance = CPU()  # Изменено имя переменной
            result = cpu_instance.choose_cpu()  # Вызов правильного метода
            if result is None:
                print("Неверный выбор процессора")
                continue

            score, name = price_calculator.add_component(result)
            print(f"Добавлен процессор {name} стоимостью {score} руб.")
            print(f"Текущая общая стоимость: {price_calculator.total_score} руб.")

        elif user_input == 'GPU':
            gpu_instance = GPU()  # Изменено имя переменной
            result = gpu_instance.choose_gpu()  # Вызов правильного метода
            if result is None:
                print("Неверный выбор видеокарты")
                continue

            score, name = price_calculator.add_component(result)
            print(f"Добавлена видеокарта {name} стоимостью {score} руб.")
            print(f"Текущая общая стоимость: {price_calculator.total_score} руб.")

# Запуск программы
if __name__ == "__main__":
    start()