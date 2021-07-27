namespace: Integrations.hcm202105_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: 127.16.239.129
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 45
        'y': 95.484375
      install_java:
        x: 265
        'y': 111.484375
      install_tomcat:
        x: 474
        'y': 134.484375
      install_aos_application:
        x: 734
        'y': 98.484375
        navigate:
          60923deb-d008-26e8-debf-a6fd67456cee:
            targetId: 4e334b6c-f7bc-8ffb-ffdf-0c0e72e179a2
            port: SUCCESS
    results:
      SUCCESS:
        4e334b6c-f7bc-8ffb-ffdf-0c0e72e179a2:
          x: 929
          'y': 76
