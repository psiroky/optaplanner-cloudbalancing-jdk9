#!/bin/sh
set -e

# clean-up of (possibly) stale content
rm -rf target/mods target/mods-src target/libs
mkdir target/mods target/mods-src target/libs

# copy the latest deps into target/libs
mvn dependency:copy-dependencies -DexcludeArtifactIds=optaplanner-cloudbalancing-jdk9 -DoutputDirectory=target/libs > target/dependecy-plugin.output

# copy the sources to a structure better consumable by the javac
mkdir target/mods-src/org.optaplanner.cloudbalancing
cp -r src/main/java/* target/mods-src/org.optaplanner.cloudbalancing
cp -r src/main/resources/* target/mods-src/org.optaplanner.cloudbalancing

"$JAVA_HOME/bin/javac" -version
"$JAVA_HOME/bin/javac" --release 9 -d target/mods --module-path target/libs --module-source-path target/mods-src $(find target/mods-src -name "*.java")
cp -r src/main/resources/* target/mods/org.optaplanner.cloudbalancing

"$JAVA_HOME/bin/jar" --create --file=target/libs/org.optaplanner.cloudbalancing.jar -C target/mods/org.optaplanner.cloudbalancing .

"$JAVA_HOME/bin/java"\
  --add-opens java.base/java.util=xstream\
  --add-opens java.base/java.lang.reflect=xstream\
  --add-opens java.base/java.text=xstream\
  --add-opens java.desktop/java.awt.font=xstream\
  --add-opens java.base/java.lang=org.drools.core\
  --module-path target/libs -m org.optaplanner.cloudbalancing/org.optaplanner.examples.cloudbalancing.app.CloudBalancingHelloWorld

# Useful debug options
# --show-module-resolution
# -Dsun.reflect.debugModuleAccessChecks=true
