def sort(main_list):
    minimum = main_list.pop()
    final = []

    for x in main_list:
        if (minimum > x):
            minimum = main_list.pop[x]
            final.append(main_list.pop[x])

    return final

def selection_sort(list_a):
    indexing_length = range(0, len(list_a)-1)

    for i in indexing_length:
        min_value = i

        for j in range(i+1, len(list_a)):
            if list_a[j] < list_a[min_value]:
                min_value = j

        if (min_value != i):
            list_a[min_value], list_a[i] = list_a[i], list_a[min_value]

    return list_a

def main():
    print(selection_sort([1, 123, 98123, 9712939123, 91826, 981723, 98167294, 1873265, 817624]))

main()
