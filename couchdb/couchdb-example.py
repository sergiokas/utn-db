from couchdb.client import Server

server = Server("http://localhost:5984")

# Si la db ya existe, es simplemente server["utn-test"]
db = server.create("utn-test")

# Cargo los datos que quiero, sin esquema
db["Sergio"]  = dict(type="user", username="sergio", firstname="Sergio", lastname="Kas", company="UTN")
db["Roberto"] = dict(type="user", username="roberto", firstname="Roberto", lastname="Gomez", company="UTN")
db["Franco"]  = dict(type="user", username="franco", firstname="Franco", lastname="Pessana", company="UTN")

# Cargo otros datos que tienen poco en comun
db["Cacarulo"] = dict(type="user", username="cacarulo", ciudad="Mar del Plata", profesion="Mago")

# Cargo datos multidimensionales
db["Multi"] = dict(type="user", username="multi", firstname="Multi", lastname="Dimension",
  skills=["python","mysql","sqlite","couchdb"],
  resume=[dict(company="IBM", year=2009), dict(company="HP", year=2011)])

# Cargo lo que sea
db["Cualquiera"] = dict(text='''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In pharetra felis et luctus egestas.
Donec libero quam, posuere sed eros ac, venenatis bibendum magna. Donec libero risus, scelerisque
ut metus ac, aliquet pharetra quam. Phasellus pulvinar erat aliquet, posuere justo a, luctus turpis.
''')

# Hago una busqueda
mapfun = '''
function(doc) {
  if(doc.type == 'user' && doc.username && doc.resume) {
    emit(doc.id, doc)
  }
}
'''

# Mi pregunta devuelve los usuarios que tengan un resume cargado
results = db.query(mapfun)
len(results)
list(results)[0]

# Actualizo
doc = db["Sergio"]
doc["ciudad"] = "Buenos Aires"
doc["intereses"] = ["Death Metal","Cumbia Cheta"]
db["Sergio"] = doc

# Borro
del db["Franco"]
