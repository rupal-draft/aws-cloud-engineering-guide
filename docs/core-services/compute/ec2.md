# Amazon EC2 Overview 🚀

![EC2 Overview Diagram](../../assets/images/ec2_overview_diagram.jpg)

## What is EC2?

**Amazon EC2 (Elastic Compute Cloud)** is like renting virtual computers in the cloud.
Instead of owning and maintaining physical servers, you can launch, manage, and destroy as many virtual machines (called "instances") as you want, with different operating systems and sizes—whenever you need.

### Why Use EC2?

- **No upfront costs:** Pay only when your instances are running.
- **Fully customizable:** Choose OS, CPU, memory, storage, network performance.
- **Scalable:** Instantly add or remove capacity as your needs change.
- **Global:** Deploy servers in many AWS regions around the world.

**Analogy:**  
It’s like booking hotel rooms for guests: add more rooms on busy days and release them when guests leave.  
You don’t build the hotel—you just use it.

---

## What is an "Instance"?

An **EC2 instance** is simply a virtual server you control.  
You decide:

- Which OS (Linux, Windows, etc.)
- How much CPU and RAM
- How much storage
- What network settings

**Example:**

- For a personal blog, you might run a small, cheap instance with Ubuntu and 1GB RAM.
- For a big company’s website, you can use powerful instances, lots of RAM, and auto-scaling.

---

## How Does EC2 Work in Real Life?

**Web Hosting:**  
Startups host their websites/applications on EC2. If traffic spikes, they can add more instances instantly and scale down to save money when demand drops.

**Development & Testing:**  
Dev teams quickly spin up test servers for new app features and destroy them after use—no need for buying costly hardware.

**Big Data Processing:**  
Researchers and companies rent powerful EC2 clusters for data crunching and machine learning (only while they need them).

**Disaster Recovery:**  
Finance companies set up EC2 backups in another AWS region—ready to go if a data center fails.

**Gaming:**  
EC2 runs servers for multiplayer online games, handling thousands of players.

---

## Key EC2 Terms Explained

| Term                           | What it Means                                        | Everyday Analogy                                               |
| ------------------------------ | ---------------------------------------------------- | -------------------------------------------------------------- |
| **Instance Type**              | Size/power of your virtual server (CPU, RAM, etc.)   | Like choosing a car: small (t2.micro) vs. big SUV (r5.8xlarge) |
| **AMI (Amazon Machine Image)** | Pre-configured OS/software template                  | Like an app installed on a phone; spin up new servers fast     |
| **Key Pair**                   | Security credentials to access your instances        | Like a house key or password; keeps your server locked         |
| **Security Group**             | Virtual firewall to control inbound/outbound traffic | Like the security guard letting only authorized persons in     |
| **Elastic IP**                 | Static public IP address for your instance           | Like assigning a fixed address to your shop                    |
| **Volume (EBS)**               | Persistent storage disk                              | Like a hard drive you can mount/unmount                        |
| **Auto Scaling**               | Automatically add/remove instances based on demand   | Like auto-increasing checkout counters during rush hour        |
| **Placement Group**            | Control how instances are placed on hardware         | Like choosing rooms close together for teamwork                |

---

## EC2 Instance Families

EC2 offers different "families" of instance types for various workloads:

- **General Purpose:** t3, m5 — Good for web apps, dev/test
- **Compute Optimized:** c5 — For CPU-intensive workloads like gaming, batch processing
- **Memory Optimized:** r5, x1 — For databases and analytics, large RAM
- **Storage Optimized:** i3, d2 — For apps that need lots of disk throughput
- **Accelerated Computing:** p3, g4 — For machine learning, AI, graphics

**Example:**  
If building a video streaming website, use general purpose for web server and storage optimized for storing videos.

---

## Pricing Models

- **On-Demand:** Pay per hour/second—start/stop anytime
- **Reserved:** Commit for 1-3 years at a lower price
- **Spot:** Use unused AWS capacity at a huge discount (but can be interrupted)—great for batch jobs
- **Savings Plans:** Flexible pricing for committed usage

**Tip:**  
Start with On-Demand for learning, experiment with Spot as you grow.

---

## High Availability and Regions

- **Regions:** Physical areas (like Mumbai, Virginia) where AWS runs data centers. Pick one close to your users.
- **Availability Zones (AZs):** Sets of isolated data centers in each region—place instances in different AZs for safety.

**Disaster Recovery Example:**  
A travel agency puts backup EC2 servers in another region to keep booking running if one area has trouble.

---

## Networking & Security

- **VPC (Virtual Private Cloud):** Your own private network inside AWS for all your instances.
- **Security Groups:** Control who can connect (allow web, block SSH, etc.).
- **SSH Keys/Passwords:** Only authorized users get access.

**Real World:**  
Think of VPC as a secured business campus, with EC2 instances inside protected offices.

---

## Storage Options

- **EBS Volumes:** Persistent, attachable block storage (like hard disks)
- **Instance Store:** Temporary local storage (cleared when you stop instance)
- **S3:** Object storage for files, images, backups (not attached as disks)

**Tip:**  
Keep databases and data on EBS for safety—EBS stays even if you restart/destroy EC2.

---

## What Can You Do With EC2?

- Launch any type of server: web, game, chatbot, database, WordPress
- Experiment: test code, build prototypes, automate boring tasks
- Deploy: scalable, global web platforms with load balancers and autoscaling
- Save money: start and stop servers as needed, pay only for resources used

---

## Big Brand Examples

- **Airbnb:** Runs their website across EC2 for millions of users
- **Expedia:** Hosts travel apps and uses EC2 to stay online globally
- **Samsung:** Delivers app store downloads from EC2 infrastructure

---

## Summary

**Amazon EC2** is the backbone of AWS cloud computing.  
Want a server? Launch it in seconds—customize everything, scale up or down, pay only for what you use, and focus on building your ideas!

# Launch Your First EC2 Instance

---

## 1. Search for EC2 in AWS Console

- From the AWS Console, use the search bar to find “EC2”.
- Click on **EC2** (Virtual Servers in the Cloud).

![Search EC2 in Console](../../assets/images/screenshots/ec2/search_ec2.png)

---

## 2. Go to Instances and Click "Launch Instance"

- In the EC2 dashboard, click **Instances** on the left sidebar.
- Hit the **Launch instances** button.

![EC2 Instances Page and Launch Button](../../assets/images/screenshots/ec2/click_on_lauch_instance_or_go_to_instances.png)
![Click Launch Instances](../../assets/images/screenshots/ec2/click_launch_instances.png)

---

## 3. Give Your Instance a Name and Pick the OS Image

- Enter any name for your instance (e.g., “My First EC2”).
- Choose an OS image (Amazon Linux, Ubuntu, Windows, etc.).

![Give Instance Name and Select OS](../../assets/images/screenshots/ec2/give_instance_name_and_select_os_image.png)

---

## 4. Select an Instance Type

- Pick an instance type based on your needs—`t3.micro` is free tier eligible and good for beginners.
- You’ll see vCPU, Memory, and pricing details to choose.

![Select Instance Type](../../assets/images/screenshots/ec2/select_instance_type.png)

---

## 5. Specify Number of Instances

- Usually, you want to launch one instance for practice.

![Select Number of Instances and Launch](../../assets/images/screenshots/ec2/select_number_of_instances_then_launch_instance.png)

---

## 6. Create or Select a Key Pair for Login

- Key pair lets you securely connect to your server via SSH.
- Choose an existing key, or click **Create new key pair** and fill in the name, type (RSA), and file format (`.pem` for Linux/macOS, `.ppk` for PuTTY/Windows).

![Create or Select Key Pair For Login](../../assets/images/screenshots/ec2/create_key_pair_or_select.png)
![Key Pair Name, Type, Format](../../assets/images/screenshots/ec2/give_key_pair_name_type_privatekey_format.png)

---

## 7. Configure Storage Size and Type

- Set the disk size you want (usually 8 GB for practice).
- gp3 is the default SSD type.

![Configure Storage](../../assets/images/screenshots/ec2/give_size_type_and_also_customize_on_advance.png)

---

## 8. (Optional) Add User Data

- In advanced settings, add bootstrapping commands (e.g., to install Apache or customize setup).

![Add User Data](../../assets/images/screenshots/ec2/on_advance_details_give_user_data.png)

---

## 9. Set Up Security Group (Firewall)

- Create a security group or select an existing one.
- Allow SSH (for remote admin) and HTTP (for web traffic) if needed.

![Create or Select Security Group, Allow HTTP](../../assets/images/screenshots/ec2/create_or_select_security_group_and_allow_http.png)

---

## 10. Review Summary and Launch

- Double-check everything, then click **Launch instance**.

![Summary and Launch](../../assets/images/screenshots/ec2/select_number_of_instances_then_launch_instance.png)

---

## 11. Verify Your EC2 Instance is Running

- Go to the **Instances page**, check your newly launched EC2 server.
- Confirm status is “Running”, note public IPv4 address.

![Verify Running Instance](../../assets/images/screenshots/ec2/verify_your_running_instance.png)

---

## 12. (Optional) Stop, Start, or Terminate

- Under **Instance state**, you can stop, start, reboot, or terminate (delete) your instance as needed.

![Change Instance State](../../assets/images/screenshots/ec2/change_instance_state.png)

---

## Summary

You’ve launched your first server in the cloud—just like renting a computer for as long as you need, whenever you want!  
Next steps: Connect via SSH using your key pair, deploy a website, or experiment with cloud automation.

# Creating IAM Role for EC2 Instance & Attaching it

---

## Step 1: Go to IAM Dashboard and Select Roles

- From the AWS Console, open the **IAM Dashboard**.
- Click on **Roles** from the left sidebar.

![Go to IAM Dashboard then Roles](../../assets/images/screenshots/ec2/go_to_iam_dashboard_then_roles.png)

---

## Step 2: Create a New Role

- Click the **Create role** button on the top right.

![Click on Create Role](../../assets/images/screenshots/ec2/click_on_create_role.png)

---

## Step 3: Select Trusted Entity Type and Usage

- Choose **AWS service** as the trusted entity type.
- Below under “Use case,” select **EC2** to allow EC2 instances to use this role.
- Click **Next** to proceed.

![Select Entity](../../assets/images/screenshots/ec2/select_entity.png)  
![Select EC2 Service](../../assets/images/screenshots/ec2/select_ec2_service.png)  
![Swipe Down Click Create Role](../../assets/images/screenshots/ec2/swipe_down_click_create_role.png)

---

## Step 4: Attach Permissions Policy

- Search and choose **IAMReadOnlyAccess** or any other necessary policy for your EC2 role.
- Click **Next**.

![Search and Select Policy](../../assets/images/screenshots/ec2/search_select_policy_next.png)

---

## Step 5: Add Role Name and Description

- Give your role a name (e.g., `MyEC2Role`) and a description.
- Review the trust policy and permissions.
- Click **Create role** to finalize.

![Give Name and Description](../../assets/images/screenshots/ec2/give_name_description.png)  
![Create Role](../../assets/images/screenshots/ec2/swipe_down_click_create_role.png)

---

## Step 6: Attach Role to EC2 Instance

- Go to the **EC2 Dashboard → Instances**.
- Select your EC2 instance.
- Click **Actions → Security → Modify IAM role**.

![Select Instance Click Action Then Security Then Modify IAM Role](../../assets/images/screenshots/ec2/select_instance_click_action_then_security_then_modify_iam_role.png)

- Choose the newly created IAM role from the dropdown.
- Click **Update IAM role**.

![Select Role Then Update](../../assets/images/screenshots/ec2/select_role_then_update.png)

---

## Step 7: Verify IAM Role Attached

- Back in the EC2 instance details page, under the **Security** tab, check that the new **IAM Role** is attached.

![Verify Attached Role](../../assets/images/screenshots/ec2/verify_attached_role.png)

---

## Summary

- You created an IAM role trusted by EC2 with read-only permissions.
- Attached this role to your EC2 instance to allow it to securely interact with other AWS services.
- Roles provide temporary and secure credentials without embedding secrets in instances.

---

This walkthrough with screenshots will help you confidently create and attach IAM roles to your EC2 instances for secure and efficient cloud operations.
