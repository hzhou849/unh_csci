## 4.1 Entities, relationships and attributes

## INDEX
#### 4.1 Entity-relationship model
#### 4.2 Discovery
#### 4.3 Cardinality


## 4.1 Entity-relationship model
An entity-relationship model is a high-level representation of data requirements, ignoring implementation details.
An entity-relationship model guides implementation in a particular database system, such as MySQL.
An entity-relationship model includes three kinds of objects:
* An entity is a person, place, product, concept, or activity. (TABLES)
* A relationship is a statement about two entities.  (How tables relationship abstract)
* An attribute is a descriptive property of an entity. (Columns)

#### Relationship
* A relationship is usually a statement about two different entities, but the two entities may be the same.
* Relationships and attributes typically becomes foreign keys and columns 
* Ie table1 holds table2
#### Reflexive relationship
* A reflexive relationship relates an entity to itself.
* ie. In a human resources systems, Employee-Manages-Employee is a reflexive relationship.

*Example: The Widgets and Digits company has projects that are composed of multiple tasks. 
Projects have a limited duration, and tasks have a starting date.
```
Project is an ENTITY - An entity is a thing, such as a person, place, or activity. Since a project is a thing, project is an entity.
Duration is an ATTRIBUTE - An attribute is a property of an entity. Since "duration of a project" describes project, duration is an attribute.
"Task belongs to project" is a relationship. A statement about two things
starting date - is an attribute
```

### Entity-relationship diagram and glossary
Entities, relationships, and attributes are depicted in an entity-relationship diagram, commonly called an ER diagram. An ER diagram depicts entities as rectangles with rounded corners, relationships as lines connecting rectangles, and attributes within entity rectangles. ER diagrams always include entities and relationships. Attributes are optional and only appear when additional detail is needed.

The full name of a relationship includes the related entities and is written "Entity-Relationship-Entity". The full name is read clockwise around the center of the relationship, as illustrated in the animation below.

* Glossary - also known as a data dictionary or repository, documents additional detail in text format. 
A glossary includes names, synonyms, and descriptions of entities, relationships, and attributes.


### Types and instances
In entity-relationship modeling, a type is a set:
* An **entity type** is a set of things. Ex: All employees in a company.
* A **relationship type** is a set of related things. Ex: Employee-Manages-Department is a set of (employee, department) pairs, where the employee manages the department.
* An **attribute type** is a set of values. Ex: All employee salaries.
Entity, relationship, and attribute types usually become tables, foreign keys, and columns, respectively.

Example: Entity Type
``` 
Students at San Antonino college - "Students" are a set of people. A set of things is an entity type..
```
Example: Relationship type
```
Students take exams - "Students take exams" is a statement about student and exam, two entity types. A statement about entity types is a relationship type.
```
Example: Attribute type
```
Student record number - "Student record number" is a set of numbers describing the student entity. A set of descriptive properties is an attribute type.
```
An instance is an element of a set:
* An **entity instance** is an individual thing. Ex: The employee Sam Snead.
* A **relationship instance** is a statement about entity instances. Ex: "Maria Rodriguez manages Sales."
* An **attribute instance** is an individual value. Ex: The salary $35,000.
Entity, relationship, and attribute instances usually become rows, foreign key values, and column values, respectively

Example:
|               | Type | Instance |
| ------------- | ---- | -------- |
| Entity | Passenger | Muhammed Ali |
| Attribute | BookingCode | 39250 |
| Relationship | Passenger-Holds-Booking | Muhammed Ali holds 39250 | 

Example: Entity instance
```
Entity instance = Eleanor Rigby, a student at San Antonio community college
"Eleanor Rigby, a student at San Antonio community college", the name refers to a student,
which is an entity instance.
```
Example:: Relationship instance
```
Eleanor Rigby takes the final exam in calculus - "Eleanor Rigby" is a student entity instance. "Final exam in calculus" is an exam entity instance. A statement about entity instances is a relationship instance.
```
Example: Attribute instance
```
'324A21' - is an individual student record number. Individual values are attribute instances.
```

### Database Design
Complex databases are developed in three phases:

1. __Analysis__ develops an entity-relationship model, capturing data requirements while ignoring implementation details.

2. __Logical design__ converts the entity-relationship model into tables, columns, and keys for a particular database system.

3. __Physical design__ adds indexes and specifies how tables are organized on storage media.

Analysis is particularly important for complex databases with many users when documenting requirements is challenging. For small databases with just a few tables and users, analysis is less important and often omitted.
Analysis and logical design steps are summarized in the table below. Although these steps are presented in sequence, in practice execution is not always sequential. Often an early step is revisited after a later step is completed.

Physical design is dependent on specific index and table structures, which vary greatly across relational databases. Physical design is discussed elsewhere in this material.

* Analysis steps:
| Step | Name |
| 1 | Discover entities, relationships and attributes |
| 2 | Determine cardinality |
| 3 | Distinguish strong and weak entities |
| 4 | Create supertype and subtype entities |

* Logical design steps
| Step | Name |
| 5 | Implement entitites |
| 6 | Implement relationships |
| 7 | Implement attributes |
| 8 | Apply Normal Form |













