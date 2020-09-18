# Tracker not ready

The tracker can become unhealthy if it is unable to communicate with it's database.
Without a connection to the database, the tracker is unable to store or query for information.

## Symptoms

The gateway process does not appear to be running or handling traffic from end user requests.

### Context

The tracker can run with a variety of connection configurations.
It accepts two parameters:

* `--storage-address` points to a database using a read/write connection.
* `--storage-readonly-address` points to a database using a read-only connection.

When using a read only connection, all queries are issued against a readonly copy.
Otherwise, all queries will go against the read-write instance.

### Troubleshooting

_What do the logs say?_

More often than not, we end up logging an error message on the server.
Should you reach an issue, there should be a corresponding log there.

_Can you query for information?_

If you're able to successfully query for information, then your read-only connection is likely working fine.
Otherwise, your read-only connection may mis-configured or not granted the proper database permissions.

_Can you store information?_

If you're able to successfully store information, then your read-write connection is likely working fine.
Otherwise, your read-write connection may be mis-configured or not granted the proper database permissions.

## Remediation Steps

_Ensure the tracker process can read the database_

This can be done using `traceroute` and ensuring the resolved ip address matches your databases.
In an address cannot be resolved, tracker cannot reach the database.

_Ensure the credentials are properly configured_

Check the configuration for the tracker process and ensure they match the expected credentials.
The tracker process may need to be restarted to pick up the new configuration.

## Next Steps

If the tracker appears to be configured properly and able to reach the database, you may need to further investigate your database.
We currently do not supply any runbooks for SQLite, MySQL, or PostgreSQL.
