{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 variable "management_vlan_id" \{\
  default = 10\
\}\
\
variable "storage_vlan_id" \{\
  default = 20\
\}\
\
variable "vlan_gateway" \{\
  default = "192.168.10.1"\
\}\
\
variable "vlan_subnet_mask" \{\
  default = "255.255.255.0"\
\}\
\
provider "vsphere" \{\
  user                 = var.vsphere_user\
  password             = var.vsphere_password\
  vsphere_server       = var.vsphere_server\
  allow_unverified_ssl = true\
\}\
\
# Management VLAN\
resource "vsphere_network" "management" \{\
  name          = "Management-VLAN"\
  datacenter_id = data.vsphere_datacenter.dc.id\
  vlan_id       = var.management_vlan_id\
  type          = "distributed"\
\}\
\
# Storage VLAN\
resource "vsphere_network" "storage" \{\
  name          = "Storage-VLAN"\
  datacenter_id = data.vsphere_datacenter.dc.id\
  vlan_id       = var.storage_vlan_id\
  type          = "distributed"\
\}\
\
# Optional: NSX-T Segment (if using NSX)\
resource "nsxt_segment" "management_segment" \{\
  display_name        = "Management-VLAN"\
  vlan_ids            = [var.management_vlan_id]\
  transport_zone_id   = data.nsxt_transport_zone.tz.id\
  subnet \{\
    cidr        = "192.168.10.0/24"\
    gateway     = var.vlan_gateway\
  \}\
\}\
\
resource "nsxt_segment" "storage_segment" \{\
  display_name        = "Storage-VLAN"\
  vlan_ids            = [var.storage_vlan_id]\
  transport_zone_id   = data.nsxt_transport_zone.tz.id\
  subnet \{\
    cidr        = "192.168.20.0/24"\
    gateway     = "192.168.20.1"\
  \}\
\}}