---
layout: post
date: "2026-11-17"
categories:
    - technology
    - code
title: Azure storage account replication is sometimes hours or days behind
---

A not-fun thing I learned today about Azure storage accounts: if you use standard geo-replication, the SLA for when your replica region will be synced...[does not exist](https://techcommunity.microsoft.com/blog/azurestorageblog/understanding-azure-storage-redundancy-offerings/1431700). Microsoft says it's typically under 15 minutes, but there are zero promises.

You can opt in to [geo priority replication](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy-priority-replication) for an extra [$0.015/GB](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/#pricing). Its SLA promises replication lag of 15 minutes or less for 99% of the billing month.

I learned this when one of my accounts hadn't synced for **MORE THAN TWO DAYS** 😭.
