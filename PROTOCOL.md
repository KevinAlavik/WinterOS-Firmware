# Frost64 Firmware Protocol

## Introduction

Very simple, work in progress

## Firmware Expectations

The firmware is expected to put the processor into protected mode, set-up a basic interrupt handling mechansim, detect and intialise any devices into a reasonable state.

## Loading the bootloader

The first 16 512-byte sectors on the storage device are reserved for the bootloader. The firmware is expected to load the bootloader from the storage device to 0x10000 and jump to it.
