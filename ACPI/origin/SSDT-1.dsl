/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20181031 (64-bit version)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-1.aml, Fri Jan 11 14:44:16 2019
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000029F (671)
 *     Revision         0x02
 *     Checksum         0x79
 *     OEM ID           "LENOVO"
 *     OEM Table ID     "CB-01   "
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "ACPI"
 *     Compiler Version 0x00040000 (262144)
 */
DefinitionBlock ("", "SSDT", 2, "LENOVO", "CB-01   ", 0x00000001)
{
    External (_SB_.GGOV, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.I2C0.DFUD, DeviceObj)
    External (_SB_.SGOV, MethodObj)    // 2 Arguments
    External (GPBS, UnknownObj)
    External (SDS0, UnknownObj)
    External (SHAP, UnknownObj)
    External (USBH, UnknownObj)

    Scope (\)
    {
        Device (SHAD)
        {
            Name (_HID, EisaId ("INT33D0"))  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _CID: Compatible ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (LOr (And (SDS0, One), And (USBH, One)))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Name (PGCE, Zero)
                Name (PGCD, Zero)
                Name (PGCG, 0x2E)
                Name (DFUE, Zero)
                Name (DFUD, Zero)
                Name (OLDV, Zero)
                Name (PGCV, Zero)
                Name (DFUV, Zero)
                If (LEqual (Arg0, ToUUID ("03c868d5-563f-42a8-9f57-9a18d949b7cb")))
                {
                    If (LEqual (SHAP, One))
                    {
                        Store (0x3A, PGCG) /* \SHAD._DSM.PGCG */
                    }

                    If (LGreaterEqual (ToInteger (Arg1), One))
                    {
                        Switch (ToInteger (Arg2))
                        {
                            Case (Zero)
                            {
                                Return (Buffer (One)
                                {
                                     0x0F                                             // .
                                })
                            }
                            Case (One)
                            {
                                Store (DerefOf (Index (Arg3, Zero)), PGCE) /* \SHAD._DSM.PGCE */
                                Store (DerefOf (Index (Arg3, One)), PGCD) /* \SHAD._DSM.PGCD */
                                Store (\_SB.GGOV (0x02010016), OLDV) /* \SHAD._DSM.OLDV */
                                \_SB.SGOV (0x02010016, PGCE)
                                If (LGreater (PGCD, Zero))
                                {
                                    Sleep (PGCD)
                                    \_SB.GGOV (0x02010016)
                                    OLDV
                                }

                                If (LEqual (\_SB.GGOV (0x02010016), One))
                                {
                                    Sleep (0x96)
                                    If (LEqual (\_SB.GGOV (0x02010014), One)){}
                                    Else
                                    {
                                        Notify (\_SB.PCI0.I2C0.DFUD, One) // Device Check
                                    }
                                }

                                Return (Zero)
                            }
                            Case (0x02)
                            {
                                Store (DerefOf (Index (Arg3, Zero)), DFUE) /* \SHAD._DSM.DFUE */
                                Store (DerefOf (Index (Arg3, One)), DFUD) /* \SHAD._DSM.DFUD */
                                Store (\_SB.GGOV (0x02010014), OLDV) /* \SHAD._DSM.OLDV */
                                \_SB.GGOV (0x02010014)
                                DFUE
                                If (LGreater (DFUD, Zero))
                                {
                                    Sleep (DFUD)
                                    \_SB.GGOV (0x02010014)
                                    OLDV
                                }

                                Return (Zero)
                            }
                            Case (0x03)
                            {
                                Store (\_SB.GGOV (0x02010014), DFUV) /* \SHAD._DSM.DFUV */
                                Store (\_SB.GGOV (0x02010016), PGCV) /* \SHAD._DSM.PGCV */
                                Return (Package (0x02)
                                {
                                    PGCV, 
                                    DFUV
                                })
                            }

                        }

                        Return (Zero)
                    }

                    Return (Zero)
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }
        }
    }
}
