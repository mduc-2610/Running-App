// import 'dart:mirrors';
//
// String getObjectDetails(dynamic object) {
//   StringBuffer buffer = StringBuffer();
//   InstanceMirror mirror = reflect(object);
//   ClassMirror classMirror = mirror.type;
//
//   buffer.write('${classMirror.simpleName}{\n');
//
//   classMirror.declarations.forEach((symbol, declaration) {
//     if (declaration is VariableMirror && !declaration.isStatic) {
//       var value = mirror.getField(symbol).reflectee;
//       buffer.write('\t${MirrorSystem.getName(symbol)}: $value\n');
//     }
//   });
//
//   buffer.write('}\n');
//   return buffer.toString();
// }