class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        root: json["root"],
        created: json["created"],
      );

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}

/*Inside the fromJson factory constructor, the values of id, root, and created properties are extracted 
from the input json object using the corresponding keys - "id", "root", and "created". These values are*/

/*then used to create a new instance of ModelsModel using the named constructor ModelsModel(id: idValue, root: rootValue, created: createdValue) 
and returned by the factory constructor.

The ModelsModel class also has a static method named modelsFromSnapshot, 
which takes a list of model snapshots as input and returns a list of ModelsModel objects. 
Inside this method, the map method is called on the modelSnapshot list to convert each snapshot into a ModelsModel
 object using the fromJson factory constructor. 
The resulting list of ModelsModel objects is returned by the modelsFromSnapshot method.*/
