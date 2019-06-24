{:user {:signing {:gpg-key "27C77EAE"}
        :plugins [[cider/cider-nrepl "0.20.0"]
                  [lein-cloverage "1.0.10-SNAPSHOT"]
                  #_[lein-pprint "1.2.0"]
                  [jonase/eastwood "0.3.5"]]
        :middleware [cider-nrepl.plugin/middleware]
        :aliases {"coverage" ["with-profile" "+cloverage" "cloverage" "--runner" "circleci.test"]}}
 :cloverage {:dependencies [[net.openhft/zero-allocation-hashing "0.8"]
                            [net.whitbeck/rdb-parser "1.3.2"]
                            [dendrite "0.5.11"]
                            [org.apache.kafka/kafka_2.11 "1.1.1" :exclusions [org.slf4j/slf4j-log4j12]]
                            [org.apache.commons/commons-math3 "3.6.1"]
                            [liftoff/clojure-csv "2.0.2-liftoff-1"]
                            [ring-mock "0.1.3"]
                            [org.imgscalr/imgscalr-lib "4.2"]
                            [com.taoensso/carmine "2.9.2" :exclusions [commons-codec]]]}
 :no-prep-tasks {:prep-tasks ^:replace ["javac" "compile"]}}
