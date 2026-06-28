# sorting.py
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        # 每一轮把最大的数沉到末尾
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr

if __name__ == "__main__":
    test_arr = [64, 34, 25, 12, 22, 11, 90]
    print("排序前:", test_arr)
    sorted_arr = bubble_sort(test_arr)
    print("排序后:", sorted_arr)