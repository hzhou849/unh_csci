#include "ItemType.h"

ItemType::ItemType() 
{

}
ItemType::ItemType(int initialValue) : m_value(initialValue) 
{

}

ItemType::RelationshipType ItemType::ComparedTo(const ItemType item)
{
	if (this->m_value < item.m_value)
	{
		return LESS;
	}
	else if (this->m_value > item.m_value)
	{
		return GREATER;
	}
	else if (this->m_value == item.m_value)
	{
		return EQUAL;
	}
}

int ItemType::getValue()
{
	return m_value;
}
