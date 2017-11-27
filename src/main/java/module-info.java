module org.optaplanner.cloudbalancing {
    requires commons.lang3;
    requires org.optaplanner.core;
    requires guava;
    requires slf4j.api;
    requires org.xmlpull.v1;

    opens org.optaplanner.examples.cloudbalancing.domain;
    opens org.optaplanner.examples.cloudbalancing.optional.domain;
    opens org.optaplanner.examples.common.domain;
    opens org.optaplanner.examples.cloudbalancing.solver;
}
