# Queue.gd
class_name Queue
var _items = [] # 内部使用数组存储数据

# 入队：将元素添加到队列末尾
func enqueue(item):
	_items.push_back(item)

# 出队：从队列开头移除并返回一个元素。如果队列为空，返回 null。
func dequeue():
	if _items.is_empty():
		return null
	return _items.pop_front()

# 查看队首元素但不移除（窥视）
func peek():
	if _items.is_empty():
		return null
	return _items[0]

func modify(i):
	_items[0]=i

# 检查队列是否为空
func is_empty() -> bool:
	return _items.is_empty()

# 获取队列长度
func size() -> int:
	return _items.size()

# 清空队列
func clear():
	_items.clear()

# 打印队列内容（用于调试）
func print_queue():
	print("Queue: ", _items)

func get_queue():
	return _items
func set_queue(i):
	_items=i

func duplicate() -> Queue:
	var new_queue = Queue.new()
	new_queue.set_queue(JSON.parse_string(JSON.stringify(_items))) # 利用JSON转换实现深拷贝
	return new_queue
