# print ruxos
ruxos_name = r"""
8888888b.                     .d88888b.   .d8888b.
888   Y88b                   d88P" "Y88b d88P  Y88b
888    888                   888     888 Y88b.
888   d88P 888  888 888  888 888     888  "Y888b.
8888888P"  888  888 `Y8bd8P' 888     888     "Y88b.
888 T88b   888  888   X88K   888     888       "888
888  T88b  Y88b 888 .d8""8b. Y88b. .d88P Y88b  d88P
888   T88b  "Y88888 888  888  "Y88888P"   "Y8888P"
print by python
""";
print(ruxos_name)

# sum 1..100
sum = 0
for i in range(0, 100):
	sum += i
print("Sum 0 - 99 = ", sum)


# get primes
i = 2
while(i < 100):
   j = 2
   while(j <= (i/j)):
      if not(i%j): break
      j = j + 1
   if (j > i/j) : print (i, " 是素数")
   i = i + 1

# test list
list1 = ['physics', 'chemistry', 1997, 2000]
print(list1)
del list1[2]
print("After deleting value at index 2 : ")
print(list1)

# test dict
country_capitals = {
  "United States": "Washington D.C.",
  "Italy": "Naples"
}

# print dictionary keys one by one
for country in country_capitals:
    print(country)

print("----------")

# print dictionary values one by one
for country in country_capitals:
    capital = country_capitals[country]
    print(capital)

# test regax
import re
m = re.search('(?<=abc)def', 'abcdef')
m.group(0)
re.split(r'\b', 'Words, words, words.')
re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')

#!/usr/bin/python
# -*- coding: UTF-8 -*-

class Parent:        # 定义父类
   parentAttr = 100
   def __init__(self):
      print ("调用父类构造函数")

   def parentMethod(self):
      print ('调用父类方法')

   def setAttr(self, attr):
      Parent.parentAttr = attr

   def getAttr(self):
      print ("父类属性 :", Parent.parentAttr)

class Child(Parent): # 定义子类
   def __init__(self):
      print ("调用子类构造方法")

   def childMethod(self):
      print ('调用子类方法')

c = Child()          # 实例化子类
c.childMethod()      # 调用子类的方法
c.parentMethod()     # 调用父类方法
c.setAttr(200)       # 再次调用父类的方法 - 设置属性值
c.getAttr()          # 再次调用父类的方法 - 获取属性值
