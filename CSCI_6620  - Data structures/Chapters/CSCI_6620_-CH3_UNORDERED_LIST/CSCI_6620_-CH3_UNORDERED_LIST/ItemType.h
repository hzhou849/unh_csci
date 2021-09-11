#pragma once

#ifndef _ITEMTYPE_H
#define _ITEMTYPE_H


class ItemType
{
public:
	ItemType();
	ItemType(int initialValue);
	
	static const int MAX_ITEMS = 10;
	enum RelationshipType {LESS, GREATER, EQUAL};
	
	RelationshipType ComparedTo(ItemType item);
	int getValue();

private:
	int m_value;
};

#endif //_ITEMTYPE_H

