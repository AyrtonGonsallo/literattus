# litteratus

A new Flutter project for books

## Getting Started
flutter est un toolkit orienté ui crée par google
creer des applications multi plateformes
basé sur dart(reprend des concepts d'autres langages)

Pourquoi flutter ?
- utiliser le meme code pour diverses plateformes
- meme langage dart pour android et ios
- un seul code a maintenir
- reduire le temps de developpement(emulateur pour voir le resultat en instantané)
- bonnes performances proche du developpement natif

Dart
orienté objet et crée par google
facile a apprendre
hot reload permet de voir de maniere instantanee le resultat produit par une modif sans reinitialiser l'app
evite l'affichage saccadé ce qui fluidifie les apps
plus besoins de fichiers séparés pour le layout

Dart
la fonction main est le point d'entrée de toute application Dart
commentaires // /**/
type nomVar=valeur;
int age;
String s1="";
var a =true; //type fixe par la suite
dynamic x=2; //type changeant

interpolation de strings
int age=25;
print("vous avez $age ans");
print("vous avez ${age} ans"); //avec évaluation
les listes
List<int> oddNum=[1,3,5];
oddNum.add(7);
print oddNum:length
spread operator
var newList = [...oddNum,...evenNumbers,8,9]
Les boucles et conditions
un if evalue les expressions booleennes
print("bienvenue ${user??'visiteur'}");
for(var player in players){
print(player);
}
les fonctions

int add(int a,int b){
return a+b;
}
arrow
add(int a,int b)=>a+b;
parametres nommés
add({int a,int b})=>a+b;
print(add(a:5,b:6));
parametres par defaut et facultatifs
int add3({int a,int b,[int c]}){
if(c==null)
c=0;
return a+b+c;
}
int add3({int a,int b,[int c=0]}){
return a+b+c;
}

Les classes et les constructeurs

class Person{
var name;
Person(this.name);

	//constructeur nommés
	Person.fromPerson(Person p){
		name=p.name;
	}

	//constructeur nommés
	Person.fromPerson(Person p):name=p.name{//initialisees avant le corps du constructeur
		print("fin du constructeur");
	}
}
pas de private, public et protected

pour rendre une propriété privée ajouter underscore
var _name;
elle ne sera visible qu'au sein de la meme librairie( du meme fichier)

Heritage

class Employee extends Person{
var jobName;
Employee(this.jobName,var name):super(name);
@override
void speak()=>print("Je suis $name et je travaille comme $jobName")

}

const et final

const b=5;

final c=5;
on ne peut les redefinir


les differences
const now=DateTime.now() //erreur car l'heure est connue a l'execution et non a la compilation
final now=DateTime.now()
aussi une liste final a son contenu non final et une liste const a son contenu const

Code asynchrone

Future<int> addAsync(int a,int b) async{
const duration=Duration(seconds:5);
await Future.delayed(duration,(){  //await indique que le compilateur doit attendre la fin de cette instruction pour passer a la ligne suivante
print("fin des 5 sec");
}) //c'est une timeout
return a+b;
}

var res=addAsync(2,5);
res.then((value) {print(value);});
print(res);

installation
mettre le zip du site a la racine et ajouter le chemin vers lib au path

flutter doctor 		verifie que tous les outis de dev flutter sont bien installés

installer android studio
Run `flutter doctor --android-licenses` to accept the SDK licenses.

installer un émulateur
creer un projet
structure d'un projet

1. .dart_tool
   Ce dossier est généré automatiquement par Flutter/Dart et contient des outils nécessaires pour le développement, comme la gestion des packages et la configuration de build. Tu n'as pas besoin de modifier ce dossier manuellement.
2. .idea
   Ce dossier est spécifique à Android Studio et contient les configurations du projet, comme les préférences de l'IDE et les paramètres de l'espace de travail. Cela inclut des fichiers de configuration pour la gestion des versions de code (VCS).
3. android
   Ce dossier contient les fichiers et le code nécessaires pour compiler et exécuter ton application sur Android. Tu trouveras ici des fichiers tels que AndroidManifest.xml, build.gradle, et d'autres fichiers spécifiques à la plateforme Android.
4. build
   Ce dossier est également généré automatiquement et contient les fichiers de build temporaires pour Android, iOS, ou autres plateformes sur lesquelles tu développes. Tu peux généralement l'ignorer, sauf si tu as besoin de nettoyer les builds (flutter clean).
5. lib
   C'est le dossier principal où tu vas écrire ton code Flutter. Le fichier main.dart, qui est le point d'entrée de l'application, se trouve généralement ici. Tu vas aussi organiser ton code en sous-dossiers pour les modèles, les widgets, les services, etc.
6. test
   Ce dossier est destiné aux tests unitaires et d'intégration de ton application. Tu peux y écrire des tests pour vérifier que ton application fonctionne comme prévu.
7. windows
   Ce dossier contient les fichiers spécifiques pour le développement sur Windows, y compris les fichiers de configuration pour générer un exécutable Windows de ton application. Similaire au dossier android, mais pour Windows.
8. Fichiers à la racine du projet
   .gitignore : Fichier de configuration pour Git, qui indique quels fichiers ou dossiers ne doivent pas être versionnés dans le dépôt Git.
   .metadata : Contient des métadonnées sur le projet, principalement pour un usage interne à Flutter.
   analysis_options.yaml : Fichier de configuration pour l'analyse statique du code Dart. Tu peux l'utiliser pour définir des règles de style de code, des lintings, etc.
   litteratus.iml : Fichier spécifique à IntelliJ/Android Studio, qui contient la configuration du projet.
   pubspec.yaml : C'est l'un des fichiers les plus importants. Il définit les dépendances de ton projet, comme les packages que tu utilises, ainsi que d'autres informations comme les assets et les fonts.
   pubspec.lock : Fichier généré automatiquement qui enregistre les versions exactes des dépendances utilisées dans ton projet.
   README.md : Fichier de documentation où tu peux expliquer ce que fait ton projet, comment l'utiliser, et toute autre information utile.
9. External Libraries
   Cette section affiche les bibliothèques externes et les dépendances que ton projet utilise, en fonction des packages déclarés dans pubspec.yaml.
10. Scratches and Consoles
    Il s'agit d'un espace de travail temporaire où tu peux écrire des morceaux de code pour les tester rapidement, sans les inclure directement dans ton projet.



Les icônes Android sont stockées dans le dossier android/app/src/main/res/.
Remplace les fichiers suivants avec tes propres icônes :
mipmap-hdpi/ic_launcher.png
mipmap-mdpi/ic_launcher.png
mipmap-xhdpi/ic_launcher.png
mipmap-xxhdpi/ic_launcher.png
mipmap-xxxhdpi/ic_launcher.png

Assure-toi que les icônes sont en PNG et ont les dimensions appropriées :
mdpi: 48x48
hdpi: 72x72
xhdpi: 96x96
xxhdpi: 144x144
xxxhdpi: 192x192


Compiler l'Application

flutter build apk --release
Le fichier APK généré sera situé dans build/app/outputs/flutter-apk/app-release.apk.

si on utilise des assets il faut les declarer dans pubspec.yaml


