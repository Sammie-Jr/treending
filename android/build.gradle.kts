buildscript {
    extensions.add("kotlinVersion", "1.7.10")
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // When bumping, also update:
        //  * ndkVersion in FlutterExtension in packages/flutter_tools/gradle/src/main/groovy/flutter.groovy
        //  * AGP version in the buildscript block in packages/flutter_tools/gradle/src/main/groovy/flutter.groovy
        //  * AGP version constants in packages/flutter_tools/lib/src/android/gradle_utils.dart
        //  * AGP version in dependencies block in packages/flutter_tools/gradle/build.gradle.kts
        classpath("com.android.tools.build:gradle:7.3.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.7.10")
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
