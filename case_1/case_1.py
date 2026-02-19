import numpy as np

list_numbers = np.array([3,-6,4,-2,2,-5,-3,-9,1,-2])


def num_sum(numbers):
    result = 0

    # e[0] - максимальный элемент
    # e[1] - минимальный элемент
    # e[2] - id максимального элемента
    # e[3] - id минимального элемента
    e = [0,0,0,0]

    # мин элемент и его id
    for i in range(len(numbers)):
        if numbers[i] < e[1]:
            e[1] = numbers[i]
            e[2] = i

    # макс элемент и его id
    for x in range(len(numbers)-1, -1, -1):
        if numbers[x] > e[0]:
            e[0] = numbers[x]
            e[3] = x

    if e[2] > e[3]:
        # для удобства при следующей итерации
        e[2],e[3] = e[3],e[2]

    # счет отрицательных чисел в промежутке
    for u in range(e[2], e[3]):
        if numbers[u] < 0:
            result += numbers[u]
    return result

result = num_sum(list_numbers)

print(result)
