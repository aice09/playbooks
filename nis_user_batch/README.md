📘 NIS Batch User Creation Guide 
This tool automates the creation of NIS accounts in batch using Ansible. It verifies if a user exists, creates them if not, sets a random password, emails credentials to the user (with CC to IT), and updates the NIS map.

✅ Prerequisites
Access to a machine with:

Ansible installed

SSH access to NIS servers

NIS server should be listed in your inventory.ini file.

Email server must be configured for Ansible mail module (usually sendmail or mailx).

📁 Project Layout
bash
Copy
Edit
nis_user_batch/
├── create_batch_nis_users.yml     # Main playbook
├── create_single_user.yml         # Task per user
├── users.yml                      # List of users to add
├── inventory.ini                  # Your NIS server(s)
🧑‍💻 How to Add New Users
Edit the users.yml file:

yaml
Copy
Edit
nis_users:
  - username: "a12345"
    full_name: "John Doe"
    email: "john.doe@example.com"
    primary_group: "Dep1"
    secondary_group: "a12345"

  - username: "b67890"
    full_name: "Jane Smith"
    email: "jane.smith@example.com"
    primary_group: "Dep2"
    secondary_group: "b67890"
🚀 How to Run It
bash
Copy
Edit
cd nis_user_batch/
ansible-playbook -i inventory.ini create_batch_nis_users.yml
You will be prompted for become (sudo) password if needed.

📧 What Happens
If the user already exists:

Admin email is notified

If the user does not exist:

Account is created

Password is randomly generated

Home directory is set up

Email is sent to the user with CC to admin(s)

make is run to update /var/yp

⚠️ Troubleshooting
If email doesn’t send:

Check mail service (sendmail, postfix) is running.

If Ansible fails to connect:

Verify SSH and inventory IP/hostname.

If the user can’t log in:

Make sure NIS is updated (/var/yp/make) and propagated.

Always verify the /etc/fstab NFS mount is working.
