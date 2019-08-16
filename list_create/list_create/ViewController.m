//
//  ViewController.m
//  list_create
//
//  Created by lizizhen on 2019/8/16.
//  Copyright © 2019 lizi' zhen. All rights reserved.
//

#import "ViewController.h"

typedef struct Node {
    int data; // 数据域
    struct Node *pNext; // 指针域
}NODE, *PNODE; // NODE等价于struct Node， PNODE等价于struct Node *

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PNODE pHead = NULL; // 等价于struct Node *pHead = NULL;
    pHead = cerate_list();
    printf("%p\n", pHead);
    traverse_list(pHead);
    
    if (is_empty(pHead))
        printf("链表为空\n");
    else
        printf("链表不为空\n");
    
    printf("链表的长度为: %d\n", length_list(pHead));
    
    sort_list(pHead);
    traverse_list(pHead);
    
    insert_list(pHead, 2, 33);
    traverse_list(pHead);
    
    int val;
    if (delete_list(pHead, 2, &val)) {
        printf("删除成功，删除的元素是：%d\n", val);
    } else {
        printf("删除失败");
    }
    traverse_list(pHead);
}

// cerate_list()功能是创建一个非循环单链表，并将该链表的头节点的地址赋给pHead
PNODE cerate_list() {
    
    int len = 3; // 用来存放有有效节点的个数
    int val = 4; // 用来临时存放用户输入的节点的值
    
    // 分配了一个不存放有效数据的头节点
    PNODE pHead = (PNODE)malloc(sizeof(NODE));
    if(pHead == NULL) {
        printf("头节点内存分配失败! 程序终止");
        exit(-1);
    }
    
    PNODE pTail = pHead; // 这个临时节点始终指向该链表的最后一个节点
    pTail->pNext = NULL;
    
    printf("请输入你需要生成的链表节点的个数 len = \n");
    //    scanf("%d", &len);
    
    for (int i = 0; i<len; ++i) {
        printf("请输入第%d个节点的值\n", i+1);
        //        scanf("%d", &val);
        
        PNODE pNew = (PNODE)malloc(sizeof(NODE));
        if(pNew == NULL) {
            printf("新节点内存分配失败! 程序终止");
            exit(-1);
        }
        // 为了方便测试数据，因为xcode没法模拟c语言scanf()函数
        if (i == 0) {
            val = 99;
        } else if (i == 1) {
            val = 66;
        } else {
            val = -32;
        }
        pNew->data = val;
        pTail->pNext = pNew;
        pNew->pNext = NULL;
        pTail = pNew;
    }
    return pHead;
}

// 遍历列表
void traverse_list(PNODE pHead) {
    PNODE p = pHead->pNext;
    while (p != NULL) {
        printf("%d  ", p->data);
        p = p->pNext;
    }
    printf("\n");
    return;
}

// 判断链表是否为空
bool is_empty(PNODE pHead) {
    if (pHead->pNext == NULL)
        return true;
    else
        return false;
}

// 获取链表的长度
int length_list(PNODE pHead) {
    PNODE p = pHead->pNext;
    int len = 0;
    while (p != NULL) {
        ++len;
        p = p->pNext;
    }
    return len;
}

void sort_list(PNODE pHead) {
    // 这是连续存储结构的排序方式，离散存储结构可仿照
    //    int len = 4;
    //    for (int i = 0; i<len-1; ++i) {
    //        for (int j = i+1; j<len; ++j) {
    //            if (a[i] < a[j]) {
    //                t = a[i];
    //                a[i] = a[j];
    //                a[i] = t;
    //            }
    //        }
    //    }
    
    int i, j, t;
    int len = length_list(pHead);
    PNODE p, q;
    
    for (i = 0, p = pHead->pNext; i<len-1; ++i, p = p->pNext) {
        for (j = i+1, q = p->pNext; j<len; ++j, q = q->pNext) {
            if (p->data > q->data) {
                t = p->data;
                p->data = q->data;
                q->data = t;
            }
        }
    }
    return;
}

// 在pHead所指向链表的第pos个节点的前面插入一个新的节点，该节点的值是val，pos的值从1开始，并且不能大于该链表的有效节点数
bool insert_list(PNODE pHead, int pos, int val) {
    
    int i = 0;
    PNODE p = pHead;
    
    while (p != NULL && i<pos-1) {
        p = p->pNext;
        ++i;
    }
    
    if(i>pos-1 || p == NULL) {
        return false;
    }
    
    PNODE pNew = (PNODE)malloc(sizeof(NODE));
    if (pNew == NULL) {
        printf("pNew内存分配失败");
        exit(-1);
    }
    pNew->data = val;
    PNODE q = p->pNext;
    p->pNext = pNew;
    pNew->pNext = q;
    
    return true;
}

bool delete_list(PNODE pHead, int pos, int *pVal) {
    
    int i = 0;
    PNODE p = pHead;
    
    while (p->pNext != NULL && i<pos-1) {
        p = p->pNext;
        ++i;
    }
    
    if(i>pos-1 || p->pNext == NULL) {
        return false;
    }
    
    // 删除之前先保留一份
    PNODE q = p->pNext;
    *pVal = q->data;
    
    // 删除p节点后面的节点
    p->pNext = p->pNext->pNext;
    free(q);
    q = NULL;
    
    return true;
}

@end
