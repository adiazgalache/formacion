# Practise: MongoDB

### Exercise 1: CRUD Operations

##### First Operations

Connecting to the terminal
```shell
$> mongo
```

Show databases
```javascript
show dbs
```

Create new database
```javascript
use ventasParticulares
```

Create collection with name `items`
```javascript
use ventasParticulares
db.createCollection('items')
```

```javascript
show dbs
```

##### Create Operations

Creating a document

```javascript
item1 = {
  descripcion: "Mando xBox negro",
  fecha: new Date ("2015, 3, 21"),
  precio: 10,
  tags: ["consolas", "xbox", "entretenimiento"],
  vendedor: {email: "pperez@gmail.com", psw: "pperez"},
  localizacion: {longitude: 37.743671, latitude: -2.552276},
  estado: "disponible",
  contraofertas: [
    {email: "llopez@gmail.com", psw: "llopez", oferta: 8,        	fecha: new Date("2015, 4, 2")},
    {email: "ggomez@gmail.com", psw: "ggomez", oferta: 7, fecha: new Date("2015, 4, 13")}
  ]
}

db.items.insert(item1)
```

Creating others documents directly
```javascript
db.items.insert({
  descripcion: "Thermomix",
  fecha: new Date ("2015, 5, 2"),
  precio: 80,
  tags: ["robot cocina", "menaje"], 
  vendedor: {email: "ffernandez@gmail.com", psw:	"ffernandez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "disponible"
})


db.items.insertOne({
  descripcion: "Mando Wii Mario",
  fecha: new Date ("2013, 10, 2"),
  precio: 8,
  tags: ["consolas", "wii", "entretenimiento"], 
  vendedor: {email: "ffernandez@gmail.com", psw: "ffernandez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "vendido",
  comprador: {email: "llopez@gmail.com", psw: "llopez"},
  contraofertas: [
    {email: "llopez@gmail.com", psw: "llopez", oferta: 7, fecha: new Date("2013, 10, 20")},
    {email: "aalonso@gmail.com", psw: "ggomez", oferta: 5, fecha: new Date("2013, 10, 19")}
  ]
})

```

Creating more than one document at the same time
```javascript
usr1={nombre:"Luis López", email: "llopez@gmail.com", psw:"llopez", direccion: {via:"C/Pez", num:3, ciudad:"Madrid", cp: "28031"}},
usr2={nombre:"Francisco Fernández", email: "ffernandez@gmail.com",	psw:"ffernandez", direccion: {via:"C/Luna Nueva", num:145, ciudad: "Barcelona", cp: "08009"}},
usr3={nombre:"Gema Gomez", email: "ggomez@gmail.com", psw:"ggomez", direccion: {via:"C/Sansa", num:28, ciudad:"Valencia", cp: "46015"}},
usr4={nombre:"Pepe Perez", email: "pperez@gmail.com", psw:"pperez", direccion: {via:"C/Sansa", num:79, ciudad:"Valencia", cp: "46015"}},  
usr5={nombre:"Ana Alonso", email: "aalonso@gmail.com", psw:"aalonso", direccion: {via:"C/Luna Llena", num:32, ciudad:"Barcelona", cp: "08009"}}

db.usuarios.insertMany([usr1, usr2, usr3, usr4, usr5])
```

##### Read Operations

Finding a document
```javascript
db.usuarios.find()
db.items.find().pretty()
```


Specifies the fields to return in the documents that match the query filter
```javascript
db.items.find({descripcion: "Thermomix"},{_id:0, precio:1})
```


Finding documents within array
```javascript
db.items.find(
    {tags: "consolas"},
    {_id:0, descripcion:1}
)
```

Finding with Expressions and comparison queries
```javascript
db.items.find({
  precio: {
    $lt: 15
  }
}).pretty()
```

Logical operations
```javascript
db.items.find( { $and: [ { precio: { $lt: 15 } }, { estado: "vendido" } ] } ).pretty()
```


Sorting operations
```javascript
db.usuarios.find().sort( { "direccion.ciudad": 1 } ).pretty()
db.usuarios.find().sort( { "direccion.ciudad": -1 } ).pretty()
```

Aggregate functions
```javascript
db.usuarios.find({}).count()
db.usuarios.count()
db.usuarios.count({"direccion.ciudad": "Valencia"})
db.items.distinct("vendedor.email")

db.items.aggregate(
  {
    $group: {
      _id: '$vendedor.email'
    }
  }
)

db.items.aggregate(
  {
    $group: {
      _id: '$vendedor.email',
      count: {$sum: 1}
    }
  }
)


db.items.aggregate(
  {
    $group: {
      _id: '$vendedor.email',
      totalPrice: { $sum: "$precio" }
    }
  }
)


db.items.aggregate(
  [
    {
      $match: {
        estado: "disponible"
      }
    },
    {
      $group: {
        _id: '$vendedor.email',
        totalPrice: { $sum: "$precio" }
      }
    }
  ]
)
```

##### Update Operations
```javascript
db.items.update(
{descripcion: "Mando xBox negro"},
{$set:{
  estado: "vendido",
 comprador: {email: "llopez@gmail.com", psw: "llopez"}}
})
```

##### Delete Operations
```javascript
db.items.remove( { estado: "vendido" } )
db.items.remove({})
```

##### Last Operations
```
db.items.drop()
db.dropDatabase()
```

### Exercise 2: Play with Dataset

