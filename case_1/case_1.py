import numpy as np

list_numbers = np.array([3, -6, 4, -2, 2, -5, -3, -9, 1, -2])

def num_sum(numbers):
    if len(numbers) == 0:
        return 0

    result = 0

    # e[0] - максимальный элемент
    # e[1] - минимальный элемент
    # e[2] - индекс минимального элемента
    # e[3] - индекс максимального элемента
    e = [numbers[0], numbers[0], 0, 0]

    # минимальный элемент и его индекс
    for i in range(len(numbers)):
        if numbers[i] < e[1]:
            e[1] = numbers[i]
            e[2] = i

    # максимальный элемент и его индекс
    for x in range(len(numbers)-1, -1, -1):
        if numbers[x] > e[0]:
            e[0] = numbers[x]
            e[3] = x

    # для удобства упорядочиваем индексы
    if e[2] > e[3]:
        e[2], e[3] = e[3], e[2]

    # суммируем отрицательные элементы между индексами
    for u in range(e[2] + 1, e[3]):
        if numbers[u] < 0:
            result += numbers[u]

    return result

result = num_sum(list_numbers)
print(result)

