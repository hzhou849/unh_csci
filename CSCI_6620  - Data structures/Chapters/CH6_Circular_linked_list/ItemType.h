/* 
 * Note with templates, The compiler cannot instantiate a fucntion template unless it knows the actual
 * parameter to the template and teh this acutal parameter apperies in the client code
 * Which is why you cannot put class definition in header and member function definition in cpp file
 * 
 * 
 * 
 * A template is not like a function which can be compiled into byte code. 
 * It is just a pattern to generate such a function. If you put a template on its own into a *.cpp file, 
 * there is nothing to compile. Moreover, the explicite instanciation is actually not a template, but the 
 * starting point to make a function out of the template which ends up in the *.obj file.
 * 
 * Compiler instantiates a template similar to a macro text replacement which is why the declaration/defintion
 * must be placed in the same file.
 */
#pragma once


#ifndef _ITEMTYPE_H
#define _ITEMTYPE_H


template <class T>
class ItemType
{
public:
	enum RelationshipType{ LESS, GREATER, EQUAL };
	
	ItemType();
	ItemType(T initialValue);
	RelationshipType ComparedTo(ItemType item);
	T getValue() const;

	// Member Variables
	static const int MAX_ITEMS = 10;

private:
	// Member Vari
	T m_value;
};
#endif //_ITEMTYPE_H


// TEMPLATE Definitions must be done in the same file as a header as this si a macro 
template <class T> 
ItemType<T>::ItemType() {}

template <class T>
ItemType<T>::ItemType(T initialValue) : m_value(initialValue) {}

template <class T>
ItemType<T>::RelationshipType ItemType<T>::ComparedTo(ItemType item)
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

template <class T>
T ItemType<T>::getValue() const
{
	return this->m_value;
}
