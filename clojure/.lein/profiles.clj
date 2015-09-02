{:user {:dependencies [[pjstadig/humane-test-output "0.7.0"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        :plugins [[lein-cloverage "1.0.2"]]}}
