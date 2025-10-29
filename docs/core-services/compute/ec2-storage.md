# EC2 Storage: Overview & Concepts

![EC2 Storage Diagram](../../assets/images/ec2_storage_overview.png)

## Why Storage is Important for EC2?

Every server (whether on AWS or at home) needs storage for:

- The Operating System (Linux, Windows, etc.)
- Applications and data (files, logs, databases)
- Temporary data (like downloads or cache)

EC2 lets you pick various storage types based on performance, durability, and cost—just like you pick hard drives or SSDs for your own computer.

---

## Types of EC2 Storage

### 1. Amazon EBS (Elastic Block Store)

- **The default and most popular option.**
- Acts like an external hard drive for your EC2 instance: you can attach, detach, resize, and move these volumes.
- **Persistent:** Data stays safe even if you stop or restart your instance.
- **Backup:** You can take snapshots (backups) and restore your server easily.

**Everyday Analogy:**  
Think of EBS like a USB drive plugged into your laptop—your files are there even if you power off.

**Example Use Cases:**

- Run a database: Data must persist across reboots.
- Store website files and logs safely.
- Add or change storage as your needs grow.

**EBS Volume Types (choose what fits your workload and budget):**

- General Purpose SSD (gp3, gp2): Balanced for most uses (web servers, dev/test).
- Provisioned IOPS SSD (io1, io2): High-performance, low-latency (databases).
- Throughput Optimized HDD (st1): Big data, streaming workloads.
- Cold HDD (sc1): Cheap storage for infrequently accessed files.

---

### 2. Instance Store (Ephemeral Storage)

- Temporary local disks physically attached to the compute host.
- **Super fast and great for short-term needs.**
- **Ephemeral:** Data is wiped if you stop/terminate/reboot your instance.
- Not available on all instance types.

**Everyday Analogy:**  
Like a computer’s RAM disk or temporary download folder—very fast, but don’t store anything important!

**Example Use Cases:**

- Storing cache files, logs, or buffers
- High-speed read/write temporary data
- Data replicated elsewhere so loss is acceptable

---

### 3. Amazon S3 (Simple Storage Service)

- Not directly attached to the instance but used for storing backups, AMIs, website assets, and snapshots.
- **Highly durable and scalable object storage.**
- Access anytime over the internet or privately within AWS.

**Everyday Analogy:**  
Like Google Drive or Dropbox for your server—access files from anywhere.

**Example Use Cases:**

- Back up your EBS volumes as snapshots
- Store images, videos, or documents with unlimited scale
- Share files between instances or with users

---

### 4. Amazon EFS (Elastic File System)

- Shared network file system—multiple Linux EC2 instances can mount at once.
- Ideal for distributed apps, content management, and data sharing.

**Everyday Analogy:**  
A shared folder on your office network—everyone on the team can use files together.

**Example Use Cases:**

- Web clusters needing shared access to code/media
- Collaborative scientific/data projects

---

### 5. Instance Storage-Optimized Instances

- EC2 "I", "D", and "H" family types offer massive, local, high-speed storage for database, analytics, and real-time workloads.
- Data is temporary—choose only if your app manages its own data replication or doesn't care about loss when powered off.

---

## Which EC2 Storage Should You Use?

| Scenario                         | Best Option    | Why?                                  |
| -------------------------------- | -------------- | ------------------------------------- |
| General-purpose web app/database | EBS gp3 SSD    | Persistent, balanced performance      |
| High-performance database        | EBS io2 SSD    | Super-fast, steady, low-latency       |
| Big data analytics/logs          | EBS st1 HDD    | High throughput for sequential access |
| Temporary cache/scratch data     | Instance Store | Fast, but will be lost on stop/delete |
| Team file sharing                | EFS            | Network file system, multi-instance   |
| Cheap, scalable backup/offload   | S3             | Safe, durable, not tied to any server |

---

## Real-World Examples

- **Startup web app:** 20 GB EBS (`gp3`) for app files + S3 for images.
- **Big data job:** Instance store volumes for calculation + EBS for results.
- **Clustered Linux servers:** All mount the same EFS for shared config.
- **Database:** Critical production DB on EBS (`io2`), regular snapshots to S3.

---

## Summary

EC2 storage is flexible—use persistent EBS for anything important, instance store for short-lived scratch, S3 for mass storage or backups, and EFS for file sharing among Linux servers.  
By matching storage type to need, you save money, keep data safe, and build fast, reliable cloud solutions.

# How to Create and Attach an EBS Volume to an EC2 Instance

---

## Step 1: Go to Volumes in EC2 Dashboard

- Open the AWS Console and search for **EC2**.
- Under **Elastic Block Store** in the left sidebar, click on **Volumes**.

![Go to Volumes then Create Volume](../../assets/images/screenshots/ec2/go_to_volumes_then_create_volume.png)

---

## Step 2: Click "Create Volume"

- On the Volumes page, click the **Create volume** button in the top right.

![Create Volume](../../assets/images/screenshots/ec2/create_volume.png)

---

## Step 3: Fill Out Volume Settings

- Pick a **volume type** (gp3 is fine for most workloads).
- Enter the **size** in GiB.
- Make sure the **Availability Zone** matches your instance’s AZ.
  - Example: If your instance is in `ap-south-1b`, your volume should be in the same.
- Leave “Snapshot ID” empty to create a brand new empty volume.

![Give Type, Size, Same AZ of Instance](../../assets/images/screenshots/ec2/give_type_size_same_az_of_instance.png)

---

## Step 4: Click "Create Volume"

- Double check settings and click **Create volume**.

![Verify Created Volume](../../assets/images/screenshots/ec2/verify_created_volume.png)

---

## Step 5: Select the Created Volume & Click "Attach Volume"

- Find your new volume in the list (state should be “available”).
- Click **Actions → Attach volume**.

![Select Created Volume Click on Actions Then Attach Volume](../../assets/images/screenshots/ec2/select_created_volume_click_on_actions_then_attach_volume.png)

---

## Step 6: Choose Instance and Device Name

- In the dialog, select your **running EC2 instance** from the dropdown.
- For Linux, use a device name like `/dev/sdb` for data volumes.
- Click **Attach volume**.

![Select Running Instance and Device Name Then Attach](../../assets/images/screenshots/ec2/select_running_instance_and_devicename_then_attach.png)

---

## Step 7: Verify the Volume is Attached

- Go back to your **EC2 Instances** page.
- Select your instance, then view the **Block devices** listed.
- You should see your new volume (`/dev/sdb`) as “attached”.

![Verify Attached Volume in Current Instance](../../assets/images/screenshots/ec2/verify_attached_volume_in_current_instance.png)

---

## What’s Next?

- If your instance runs Linux, you need to format and mount the volume so your system can use it (via SSH, run `lsblk`, `mkfs`, and `mount`).
- For Windows, use Disk Management to bring the disk online and format it.

---

## Summary

In these simple steps, you’ve added extra storage to your running EC2 server—just like plugging an external drive into a PC.  
This is perfect for growing apps, separating data, and backing up files.

# Creating Snapshots from EBS Volumes & Managing Snapshots

---

## Step 1: Select Volume and Create Snapshot

- Go to **Volumes** under Elastic Block Store in EC2.
- Click the volume you want to back up.
- From the **Actions** menu, click **Create snapshot**.

![Select Volume Then Actions Then Create Snapshot](../../assets/images/screenshots/ec2/select_volume_then_actions_then_create_snapshot.png)

---

## Step 2: Give Your Snapshot a Description and Create

- In the dialog, enter a meaningful description (e.g. "MyDemoSnapshot").
- Click **Create snapshot**.

![Give Snapshot Description Then Create](../../assets/images/screenshots/ec2/give_snapshot_description_then_create.png)

---

## Step 3: Verify Your Snapshot

- Go to **Snapshots** in the left sidebar.
- Your new snapshot will appear in the list.
- Check that **Snapshot Status** is "Completed" and progress is 100%.

![Verify Created Snapshot](../../assets/images/screenshots/ec2/verify_created_snapshot.png)

---

## Step 4: Snapshot Actions (Create Volume, Copy, Delete)

### A. Create a Volume from Snapshot

- Select the snapshot, open **Actions** and click **Create volume from snapshot**.
- Fill in the desired volume type, size, and availability zone.

![Select Snapshot Can Create Volume](../../assets/images/screenshots/ec2/select_snapshot_can_create_volume_copy_and_delete_snapshot.png)
![Can Create Volume Of Other AZ From Snapshot](../../assets/images/screenshots/ec2/can_create_volume_of_other_az_from_snapshot.png)
![Verify Created Volume From Snapshot](../../assets/images/screenshots/ec2/verify_created_volume_from_snapshot.png)

### B. Copy Snapshot to Another Region

- With snapshot selected, choose **Actions → Copy snapshot**.
- Pick the destination region and description.

![Can Copy Snapshot To Other Region](../../assets/images/screenshots/ec2/can_copy_snapshot_to_other_region.png)

### C. Delete Snapshot & Recycle Bin Recovery

- When you delete a snapshot, it goes to the AWS Recycle Bin (if retention policy exists).
- To recover, go to **Recycle Bin → Resources**, select the snapshot, and click **Recover**.

![Can Recover Deleted Snapshots From Recycle Bin](../../assets/images/screenshots/ec2/can_recover_deleted_snapshots_from_recycle_bin.png)

---

## Step 5: Set Up Retention Rules for Snapshots

- In **Recycle Bin → Retention rules**, create a new rule.
- Choose resource type **EBS snapshots**, and whether to retain all or by tag.
- This ensures deleted snapshots are recoverable for a set number of days.

![Can Create Retention Rule For Snapshots In Recycle Bin](../../assets/images/screenshots/ec2/can_create_retention_rule_for_snapshots_in_recycle_bin.png)

---

## Summary

**EBS Snapshots** let you:

- Back up and restore volumes at any time.
- Clone volumes for different regions or Availability Zones.
- Recover mistakenly deleted snapshots easily when using retention rules.
- Keep your cloud data safe with easy, point-in-time recovery.

# How to Create and Attach an Amazon EFS File System

---

## Step 1: Search for EFS in AWS Console

- From the AWS Console, search for **EFS**.
- Select **EFS (Managed File Storage for EC2)**.

![Search for EFS](../../assets/images/screenshots/ec2/search_efs.png)

---

## Step 2: Click "Create file system"

- On the EFS dashboard, click **Create file system**.

![Create File System Button](../../assets/images/screenshots/ec2/create_efs.png)

---

## Step 3: Enter EFS Name and Choose Settings

- Give your file system a name (optional but recommended).
- You can go with the default (recommended settings) or click **Customize** for advanced options.

![Give Name of EFS Then Customize or Create](../../assets/images/screenshots/ec2/give_name_of_efs_then_either_customize_or_create.png)

---

## Step 4: Set File System Type and Lifecycle (Customize - Optional)

- On the customize screen, choose **Regional** for maximum durability (recommended).
- Configure lifecycle transition rules if you want files to move to infrequent or archive storage based on last access (good for saving costs over time).

![Customize: Name, Type, Lifecycle](../../assets/images/screenshots/ec2/in_customize_give_name_type_and_days_after_which_data_becomes_infrequent_access.png)

---

## Step 5: Set Network and Mount Targets Across AZs

- Select your VPC and subnets for each Availability Zone.
- EFS creates **mount targets** in each AZ, enabling high availability and cross-AZ access.

![Select VPC and Mount Targets for AZs](../../assets/images/screenshots/ec2/select_vpc_and_mount_targets_for_azs.png)

---

## Step 6: File System Policy (Optional)

- Expand the **File system policy** section to restrict actions using resource policies if required.
- This helps manage security for who can access the file system.

![File System Policy Step](../../assets/images/screenshots/ec2/give_policy_then_create.png)

---

## Step 7: Click "Create"

- Review your settings, then click **Create** to provision the EFS.

---

## Step 8: Verify EFS Creation

- EFS will appear in your file systems list, status as "Creating" and then "Available".

![Verify Created EFS](../../assets/images/screenshots/ec2/verify_created_efs.png)

---

## Step 9: Attach EFS to EC2 When Launching Instance

- When launching an EC2 instance, in **Storage (volumes)**, go to **File systems**.
- Choose “Add shared file system” and select your new EFS from the list.

![While Creating Instance: Storage Settings, Select EFS, Add Shared File](../../assets/images/screenshots/ec2/while_creating_instance_second_in_storage_settings_select_efs_then_add_shared_file_system.png)
![Add the EFS You Have Created](../../assets/images/screenshots/ec2/add_the_efs_you_have_created.png)

---

## Step 10: Select Correct Subnet (AZ)

- In **Network settings** during instance creation, choose a subnet in the same Availability Zone as one of the EFS mount targets for optimal performance.

![Select Subnet According to AZ](../../assets/images/screenshots/ec2/while_creating_instance_first_in_network_settings_select_subnet_according_to_az.png)

---

## Summary

With these steps, you:

- Created an EFS file system that can be shared by many EC2s (like a NAS for your cloud).
- Attached it to your EC2 by selecting EFS on launch, or by mounting it on existing instances.
- Set lifecycle and accessibility rules for durability, cost management, and security.
