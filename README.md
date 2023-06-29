# Historian CDC Setup Script

This script automates the setup process for creating namespaces and deploying resources in a Kubernetes cluster. It performs the following tasks:

- Creates namespace for Debezium.
- Deploys Debezium Operator.
- Deploys the Debezium Server.

## Prerequisites

Before running this script, ensure that you have the following prerequisites:

- Kubernetes cluster is up and running.
- `kubectl` is installed and configured to connect to your cluster.

## Installation

1. Clone this repository:
   If you've already cloned, clone the hist-cdc repository onto the commtel server:
   ```git clone git@ssh.dev.azure.com:v3/Codvo/commtel/hist-cdc```

2. Run the Following script:
   * Navigate to the repository directory:
        ```cd hist-cdc```
   
   * Make the script executable:
        ```chmod 755 ./install-hist-cdc.sh```
   
   * Run the script:
        ```./install-hist-cdc.sh```

## Testing

After running the setup script, you can perform the following tests to ensure the deployment is successful and the resources are running as expected:

1. Check the status of pods:
    ```kubectl get pods -n debezium```

    This command will display the pods in the debezium namespace. Ensure that all the required pods are in a Running state.

2. Verify the status of deployments:
    ```kubectl get deployment -n debezium```
    This command will list the deployments in the debezium namespace. Confirm that the desired number of replicas are available and that the deployments are in a Ready state.

3. Check the status of services:
    ```kubectl get service -n debezium```
    This command will show the services in the debezium namespace. Ensure that the services are running and have the expected endpoints.

If all the commands return the expected output and the resources are in the desired state, it indicates a successful deployment of the Debezium components in the debezium namespace.

If any of the commands display errors or the resources are not in the expected state, review the output for any error messages, check the logs of the affected pods, and consult the troubleshooting section of the documentation for further assistance.

## Test for Change Data Capture (CDC) logs using NATS:

To verify that CDC logs are being generated and processed correctly, you can follow these steps:

1. Subscribe to the NATS subject or topic where Debezium publishes the CDC events.

2. Use a NATS client tool or utility to subscribe to the subject and verify that the captured change events are being received by NATS.

3. Example NATS subscription command:
    ```nats-sub <nats-subject>```
    
    Replace <nats-subject> with the actual NATS subject or topic where Debezium publishes the CDC events.  

    **Ensure that the subject or topic that you add must match with the subject that you have provided in the debezium-server.yml configs.** 
    
    If you receive the change events in the NATS subscriber, it indicates that the CDC logs are successfully processed and forwarded to NATS.

## Uninstallation

To uninstall the hist-cdc application and its associated resources, follow these steps:

1. Change into the hist-cdc directory:
    ```cd hist-cdc```

2. Make sure the uninstallation script has executable permissions:
    ```chmod 755 ./uninstall-hist-cdc.sh```

3. Run the uninstallation script:
    ```./uninstall-hist-cdc.sh```

This script will remove all the resources deployed by the hist-cdc application, including pods, deployments, services, and any other related objects.

4. Verify the resources have been successfully removed:
    After running the uninstallation script, you can verify the uninstallation status of the resources to ensure they have been deleted by executing commands mentioned in the
    **Testing** section mentioned above

If all the commands indicate that the resources have been successfully removed, it means that the hist-cdc application and its associated resources have been uninstalled from your cluster.

## Troubleshooting

If you encounter any issues while using the hist-cdc application, try the following troubleshooting steps:

* **Issue**: Pods are not in a running state.
  
  **Resolution**: Check the pod logs for any error messages by running the following command:

  ``` kubectl logs <pod-name> -n debezium```

    Look for any error messages or stack traces that could indicate the cause of the issue. Additionally, ensure that the required resources are properly configured and available.

    Issue: Connection to the database is failing.

    Resolution: Double-check the database connection details in the configuration file (debezium-server). Ensure that the hostname, port, username, password, and database name are correct. Verify that the database server is accessible and reachable from the application's network.

* **Issue**: Connection to the database is failing.
    
**Resolution**: If you are experiencing connection issues between Debezium and the database, follow these steps:

    1. Check the database connection details in the Debezium configuration file (under `debezium-server.yml`). Ensure that the hostname, port, username, password, and database name are correct.

    2. Verify that the database server allows connections from the Debezium container or pod. Depending on your setup, you may need to update the firewall rules or network configurations to allow the required communication.

    3. Confirm that the database user specified in the Debezium configuration has the necessary privileges and permissions to access the specified database. Check that the user has appropriate read permissions for the tables and schemas you want to capture changes from.

    4. Ensure that the database server is accessible and reachable from the network where Debezium is deployed. You can try to connect to the database using a database client tool or utility from the same network to verify connectivity.

    5. Check the logs of the Debezium connector for any error messages or warnings related to the database connection. You can retrieve the logs using the following command:

        ```shell
        kubectl logs <debezium-connector-pod> -n debezium
        ```

        Look for any specific error messages or stack traces that indicate the cause of the connection failure. Pay attention to any authentication errors, network connectivity issues, or permission-related problems.

* **Issue**: Connection to the NATS messaging system is failing.
    
**Resolution**: If you are experiencing connection issues between Debezium and NATS, follow these steps:

    1. Check the NATS connection details in the Debezium configuration file (under `debezium-server.yml`). Ensure that the NATS server URL, including the hostname and port, is correct.

    2. Verify that the NATS messaging system is running and accessible from the network where Debezium is deployed. You can try connecting to the NATS server using a NATS client tool or utility to ensure connectivity.

    3. Confirm that the necessary details, such as url, create-stream and subjects, are correctly specified in the Debezium configuration file.

    4. Check the network connectivity between the Debezium container or pod and the NATS messaging system. Ensure that there are no network restrictions, such as firewalls or security groups, blocking the communication.

    5. Validate that the Debezium connector is using the correct NATS subject or topic to publish the captured change events. Verify that the Debezium connector configuration and the consuming components (e.g., subscribers) are aligned with the same subject or topic.

    6. Review the logs of the Debezium connector for any error messages or warnings related to the NATS connection. Retrieve the logs using the following command:

        ```shell
        kubectl logs <debezium-connector-pod> -n debezium
        ```

        Look for any specific error messages or stack traces that indicate the cause of the connection failure. Pay attention to any authentication errors, network connectivity issues, or permission-related problems.
