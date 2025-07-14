import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StaticScreen extends StatelessWidget {
  const StaticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox24,
              CustomAppBar(name: 'In Case You Need It'),
              heightBox12,
              Text(
                'Crisis Toolkit Library',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'For when things get heavy. You are not alone.',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
              heightBox12,
              Text(
                '1. After Assault - What To Do',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Immediate Help - Nigeria:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• WARIF Centre (Lagos): +234 807 709 2007\n'
                '• Mirabel Centre (Lagos): +234 815 510 5167\n'
                '• FIDA (Legal Aid): +234 803 787 0516\n'
                '• Stand to End Rape (STER): +234 809 119 6265\n'
                '• SGBV Response Abuja: +234 803 928 8055 (Ministry of Women Affairs)',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                'Step-by-Step:',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                '1. Get to a safe location (friend’s house, hospital, station).\n'
                '2. Don’t shower or change if you might want to preserve evidence.\n'
                '3. Go to a sexual assault referral centre or hospital – request a rape kit (forensic exam).\n'
                '4. Request emergency contraception (Plan B) and HIV Post-Exposure Prophylaxis (PEP) within 72 hours.\n',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox4,
              Text(
                'What to Say at the Hospital:',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                '“I need treatment and want to preserve evidence of sexual assault. Please assign a SGBV-trained officer or nurse/doctor if possible.”',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                'Gentle Reminder:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
              heightBox8,
              Text(
                'You did nothing wrong. You are still whole. You are right. Whatever you choose to do next, it’s your right.',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                '2. Panic Button / Check-in FAQ',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Panic Button:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• Press and hold for 3 seconds\n'
                '• Your selected contacts receive\n'
                '• Your location\n'
                '• Your emergency message\n'
                '\n'
                'If Your Check-in Timer Expires:\n'
                '• Trusted contacts will get an alert saying you missed a check-in\n'
                '• Encourage them to call you immediately or check your last known location',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                '3. Sexual Health (Emergency Info)',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Plan B (Emergency Contraceptive):\n'
                '• Most effective within 72 hours\n'
                '• Can be found at major pharmacies (HealthPlus, Medplus, local clinics)\n'
                '\n'
                'HIV Prevention (PEP):\n'
                '• Take within 72 hours after exposure\n'
                '• Available at Lagos University Teaching Hospital (LUTH) National Agency for the Control of AIDS (NACA): +234 813 976 7896\n'
                '• Specialist HIV clinics (ask for “PEP” unit)\n'
                '\n'
                'STI Screening:\n'
                '• After 2 weeks: test for chlamydia, gonorrhea, syphilis, and HIV\n'
                '\n'
                'Pregnancy Support:\n'
                '• You can access a free urine pregnancy test at most general hospitals\n'
                '• If you’re unsure what to do next: talk to a therapist or trained counselor through the app',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                '4. Mental Breakdown or Overwhelm',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Grounding Techniques:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• 5 things you see\n'
                '• 4 things you can touch\n'
                '• 3 things you hear\n'
                '• 2 things you smell\n'
                '• 1 thing you can taste\n'
                '\n'
                'Breathe With Me (4-7-8):\n'
                '• Inhale 4 seconds – Hold 7 – Exhale 8\n'
                '• Repeat 3x\n'
                '• Say out loud: “I am safe in this moment.”\n'
                '\n'
                'Call Now (Mental Health Hotlines):\n'
                '• Mentally Aware Nigeria (MANI): +234 803 942 5488\n'
                '• She Writes Woman: +234 915 234 0006\n'
                '• Mirabel Centre: +234 815 510 5167\n'
                '• UNILAG Suicide Prevention Line: +234 813 777 7724',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                '5. Abuse & Control Warning Signs',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Emotional Abuse Checklist:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• They feel afraid of their anger\n'
                '• They check your phone or messages\n'
                '• You’re constantly apologizing, even when you’re not\n'
                '• You feel like “you’re the problem” even when you’re not\n'
                '\n'
                'Control vs Safety - Self-Reflection Tool:\n'
                '“Is this love or fear? Would I want my sister treated this way?”\n'
                '\n'
                'Digital Safety Tips:\n'
                '• Disable location sharing on WhatsApp, Instagram\n'
                '• Clear browser history after searching sensitive topics\n'
                '• Use incognito mode or private tabs',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                '6. Legal Resources (Nigeria)',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Hotlines & Centers:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• WARIF Legal Aid: +234 807 709 2007\n'
                '• FIDA Nigeria: +234 803 787 0516\n'
                '• Mirabel Centre: +234 815 510 5167\n'
                '• NAPTIP Abuja (Human Trafficking/Sexual Exploitation): +234 703 000 0203\n'
                '\n'
                'What to Expect When Reporting:\n'
                '• Ask for a Family Support Unit or Gender Desk\n'
                '• You can request a female officer\n'
                '• Request they document a written statement (you can take a photo of it)\n'
                '• You do not need a bribe or lawyer to begin reporting',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox12,
              Text(
                '7. Emotional Support Resources',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightBox8,
              Text(
                'Hotlines for Support:',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• She Writes Woman: +234 915 234 0006\n'
                '• MANI: +234 803 942 5488\n'
                '• Mirabel Centre: +234 815 510 5167\n'
                '• ND Suicide Prevention Initiative: +234 806 210 6493\n'
                '\n'
                'Activities to Try:\n'
                '• Listen to calming audio in the Letters to Your tab\n'
                '• Book a session under “A Listening Ear”\n'
                '• Write in your Safe Notes',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              heightBox24,
            ],
          ),
        ),
      ),
    );
  }
}
