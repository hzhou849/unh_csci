
#pragma once

#ifndef _ITEMTYPE_H
#define _ITEMTYPE_H

enum RelationshipType{ LESS, GREATER, EQUAL };

class ItemType
{
public:
	
	ItemType();
	ItemType(int initialValue);
	RelationshipType ComparedTo(ItemType item);
	int getValue() const;

	// Member Variables
	static const int MAX_ITEMS = 10;

private:
	// Member Vari
	int  m_value;
};
#endif //_ITEMTYPE_H


ItemType::ItemType():m_value(0) {}

ItemType::ItemType(int  initialValue) : m_value(initialValue) {}

RelationshipType ItemType::ComparedTo(ItemType item)
{
	
	if (this->m_value < item.getValue() )
	{
		return LESS;
	}
	else if (this->m_value > item.getValue() )
	{
		return GREATER;
	}
	else if (this->m_value == item.getValue() )
	{
		return EQUAL;
	}
}

int ItemType::getValue() const
{
	return this->m_value;
}