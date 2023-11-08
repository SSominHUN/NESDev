/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/NESDev/NES_hw/NES_fpga_hw/src/ppu/sprite_mux.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {255U, 254U};
static unsigned int ng3[] = {254U, 252U};
static unsigned int ng4[] = {252U, 248U};
static unsigned int ng5[] = {248U, 240U};
static unsigned int ng6[] = {240U, 224U};
static unsigned int ng7[] = {224U, 192U};
static unsigned int ng8[] = {192U, 128U};
static unsigned int ng9[] = {128U, 0U};
static unsigned int ng10[] = {1U, 0U};



static void NetDecl_57_0(char *t0)
{
    char t3[8];
    char t5[8];
    char t15[8];
    char t23[8];
    char t53[8];
    char t63[8];
    char t71[8];
    char t101[8];
    char t111[8];
    char t119[8];
    char t149[8];
    char t159[8];
    char t167[8];
    char t197[8];
    char t207[8];
    char t215[8];
    char t245[8];
    char t255[8];
    char t263[8];
    char t293[8];
    char t303[8];
    char t311[8];
    char t341[8];
    char t351[8];
    char t359[8];
    char *t1;
    char *t2;
    char *t4;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    char *t51;
    char *t52;
    char *t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    char *t61;
    char *t62;
    char *t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    char *t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    char *t85;
    char *t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    char *t99;
    char *t100;
    char *t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    char *t109;
    char *t110;
    char *t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    char *t123;
    char *t124;
    char *t125;
    unsigned int t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    char *t133;
    char *t134;
    unsigned int t135;
    unsigned int t136;
    unsigned int t137;
    int t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    int t142;
    unsigned int t143;
    unsigned int t144;
    unsigned int t145;
    unsigned int t146;
    char *t147;
    char *t148;
    char *t150;
    unsigned int t151;
    unsigned int t152;
    unsigned int t153;
    unsigned int t154;
    unsigned int t155;
    unsigned int t156;
    char *t157;
    char *t158;
    char *t160;
    unsigned int t161;
    unsigned int t162;
    unsigned int t163;
    unsigned int t164;
    unsigned int t165;
    unsigned int t166;
    unsigned int t168;
    unsigned int t169;
    unsigned int t170;
    char *t171;
    char *t172;
    char *t173;
    unsigned int t174;
    unsigned int t175;
    unsigned int t176;
    unsigned int t177;
    unsigned int t178;
    unsigned int t179;
    unsigned int t180;
    char *t181;
    char *t182;
    unsigned int t183;
    unsigned int t184;
    unsigned int t185;
    int t186;
    unsigned int t187;
    unsigned int t188;
    unsigned int t189;
    int t190;
    unsigned int t191;
    unsigned int t192;
    unsigned int t193;
    unsigned int t194;
    char *t195;
    char *t196;
    char *t198;
    unsigned int t199;
    unsigned int t200;
    unsigned int t201;
    unsigned int t202;
    unsigned int t203;
    unsigned int t204;
    char *t205;
    char *t206;
    char *t208;
    unsigned int t209;
    unsigned int t210;
    unsigned int t211;
    unsigned int t212;
    unsigned int t213;
    unsigned int t214;
    unsigned int t216;
    unsigned int t217;
    unsigned int t218;
    char *t219;
    char *t220;
    char *t221;
    unsigned int t222;
    unsigned int t223;
    unsigned int t224;
    unsigned int t225;
    unsigned int t226;
    unsigned int t227;
    unsigned int t228;
    char *t229;
    char *t230;
    unsigned int t231;
    unsigned int t232;
    unsigned int t233;
    int t234;
    unsigned int t235;
    unsigned int t236;
    unsigned int t237;
    int t238;
    unsigned int t239;
    unsigned int t240;
    unsigned int t241;
    unsigned int t242;
    char *t243;
    char *t244;
    char *t246;
    unsigned int t247;
    unsigned int t248;
    unsigned int t249;
    unsigned int t250;
    unsigned int t251;
    unsigned int t252;
    char *t253;
    char *t254;
    char *t256;
    unsigned int t257;
    unsigned int t258;
    unsigned int t259;
    unsigned int t260;
    unsigned int t261;
    unsigned int t262;
    unsigned int t264;
    unsigned int t265;
    unsigned int t266;
    char *t267;
    char *t268;
    char *t269;
    unsigned int t270;
    unsigned int t271;
    unsigned int t272;
    unsigned int t273;
    unsigned int t274;
    unsigned int t275;
    unsigned int t276;
    char *t277;
    char *t278;
    unsigned int t279;
    unsigned int t280;
    unsigned int t281;
    int t282;
    unsigned int t283;
    unsigned int t284;
    unsigned int t285;
    int t286;
    unsigned int t287;
    unsigned int t288;
    unsigned int t289;
    unsigned int t290;
    char *t291;
    char *t292;
    char *t294;
    unsigned int t295;
    unsigned int t296;
    unsigned int t297;
    unsigned int t298;
    unsigned int t299;
    unsigned int t300;
    char *t301;
    char *t302;
    char *t304;
    unsigned int t305;
    unsigned int t306;
    unsigned int t307;
    unsigned int t308;
    unsigned int t309;
    unsigned int t310;
    unsigned int t312;
    unsigned int t313;
    unsigned int t314;
    char *t315;
    char *t316;
    char *t317;
    unsigned int t318;
    unsigned int t319;
    unsigned int t320;
    unsigned int t321;
    unsigned int t322;
    unsigned int t323;
    unsigned int t324;
    char *t325;
    char *t326;
    unsigned int t327;
    unsigned int t328;
    unsigned int t329;
    int t330;
    unsigned int t331;
    unsigned int t332;
    unsigned int t333;
    int t334;
    unsigned int t335;
    unsigned int t336;
    unsigned int t337;
    unsigned int t338;
    char *t339;
    char *t340;
    char *t342;
    unsigned int t343;
    unsigned int t344;
    unsigned int t345;
    unsigned int t346;
    unsigned int t347;
    unsigned int t348;
    char *t349;
    char *t350;
    char *t352;
    unsigned int t353;
    unsigned int t354;
    unsigned int t355;
    unsigned int t356;
    unsigned int t357;
    unsigned int t358;
    unsigned int t360;
    unsigned int t361;
    unsigned int t362;
    char *t363;
    char *t364;
    char *t365;
    unsigned int t366;
    unsigned int t367;
    unsigned int t368;
    unsigned int t369;
    unsigned int t370;
    unsigned int t371;
    unsigned int t372;
    char *t373;
    char *t374;
    unsigned int t375;
    unsigned int t376;
    unsigned int t377;
    int t378;
    unsigned int t379;
    unsigned int t380;
    unsigned int t381;
    int t382;
    unsigned int t383;
    unsigned int t384;
    unsigned int t385;
    unsigned int t386;
    char *t387;
    char *t388;
    char *t389;
    char *t390;
    char *t391;
    unsigned int t392;
    unsigned int t393;
    char *t394;
    unsigned int t395;
    unsigned int t396;
    char *t397;
    unsigned int t398;
    unsigned int t399;
    char *t400;

LAB0:    t1 = (t0 + 4768U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1848U);
    t4 = *((char **)t2);
    memset(t5, 0, 8);
    t2 = (t5 + 4);
    t6 = (t4 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (t7 >> 0);
    t9 = (t8 & 1);
    *((unsigned int *)t5) = t9;
    t10 = *((unsigned int *)t6);
    t11 = (t10 >> 0);
    t12 = (t11 & 1);
    *((unsigned int *)t2) = t12;
    t13 = (t0 + 1848U);
    t14 = *((char **)t13);
    memset(t15, 0, 8);
    t13 = (t15 + 4);
    t16 = (t14 + 4);
    t17 = *((unsigned int *)t14);
    t18 = (t17 >> 1);
    t19 = (t18 & 1);
    *((unsigned int *)t15) = t19;
    t20 = *((unsigned int *)t16);
    t21 = (t20 >> 1);
    t22 = (t21 & 1);
    *((unsigned int *)t13) = t22;
    t24 = *((unsigned int *)t5);
    t25 = *((unsigned int *)t15);
    t26 = (t24 | t25);
    *((unsigned int *)t23) = t26;
    t27 = (t5 + 4);
    t28 = (t15 + 4);
    t29 = (t23 + 4);
    t30 = *((unsigned int *)t27);
    t31 = *((unsigned int *)t28);
    t32 = (t30 | t31);
    *((unsigned int *)t29) = t32;
    t33 = *((unsigned int *)t29);
    t34 = (t33 != 0);
    if (t34 == 1)
        goto LAB4;

LAB5:
LAB6:    t51 = (t0 + 2008U);
    t52 = *((char **)t51);
    memset(t53, 0, 8);
    t51 = (t53 + 4);
    t54 = (t52 + 4);
    t55 = *((unsigned int *)t52);
    t56 = (t55 >> 0);
    t57 = (t56 & 1);
    *((unsigned int *)t53) = t57;
    t58 = *((unsigned int *)t54);
    t59 = (t58 >> 0);
    t60 = (t59 & 1);
    *((unsigned int *)t51) = t60;
    t61 = (t0 + 2008U);
    t62 = *((char **)t61);
    memset(t63, 0, 8);
    t61 = (t63 + 4);
    t64 = (t62 + 4);
    t65 = *((unsigned int *)t62);
    t66 = (t65 >> 1);
    t67 = (t66 & 1);
    *((unsigned int *)t63) = t67;
    t68 = *((unsigned int *)t64);
    t69 = (t68 >> 1);
    t70 = (t69 & 1);
    *((unsigned int *)t61) = t70;
    t72 = *((unsigned int *)t53);
    t73 = *((unsigned int *)t63);
    t74 = (t72 | t73);
    *((unsigned int *)t71) = t74;
    t75 = (t53 + 4);
    t76 = (t63 + 4);
    t77 = (t71 + 4);
    t78 = *((unsigned int *)t75);
    t79 = *((unsigned int *)t76);
    t80 = (t78 | t79);
    *((unsigned int *)t77) = t80;
    t81 = *((unsigned int *)t77);
    t82 = (t81 != 0);
    if (t82 == 1)
        goto LAB7;

LAB8:
LAB9:    t99 = (t0 + 2168U);
    t100 = *((char **)t99);
    memset(t101, 0, 8);
    t99 = (t101 + 4);
    t102 = (t100 + 4);
    t103 = *((unsigned int *)t100);
    t104 = (t103 >> 0);
    t105 = (t104 & 1);
    *((unsigned int *)t101) = t105;
    t106 = *((unsigned int *)t102);
    t107 = (t106 >> 0);
    t108 = (t107 & 1);
    *((unsigned int *)t99) = t108;
    t109 = (t0 + 2168U);
    t110 = *((char **)t109);
    memset(t111, 0, 8);
    t109 = (t111 + 4);
    t112 = (t110 + 4);
    t113 = *((unsigned int *)t110);
    t114 = (t113 >> 1);
    t115 = (t114 & 1);
    *((unsigned int *)t111) = t115;
    t116 = *((unsigned int *)t112);
    t117 = (t116 >> 1);
    t118 = (t117 & 1);
    *((unsigned int *)t109) = t118;
    t120 = *((unsigned int *)t101);
    t121 = *((unsigned int *)t111);
    t122 = (t120 | t121);
    *((unsigned int *)t119) = t122;
    t123 = (t101 + 4);
    t124 = (t111 + 4);
    t125 = (t119 + 4);
    t126 = *((unsigned int *)t123);
    t127 = *((unsigned int *)t124);
    t128 = (t126 | t127);
    *((unsigned int *)t125) = t128;
    t129 = *((unsigned int *)t125);
    t130 = (t129 != 0);
    if (t130 == 1)
        goto LAB10;

LAB11:
LAB12:    t147 = (t0 + 2328U);
    t148 = *((char **)t147);
    memset(t149, 0, 8);
    t147 = (t149 + 4);
    t150 = (t148 + 4);
    t151 = *((unsigned int *)t148);
    t152 = (t151 >> 0);
    t153 = (t152 & 1);
    *((unsigned int *)t149) = t153;
    t154 = *((unsigned int *)t150);
    t155 = (t154 >> 0);
    t156 = (t155 & 1);
    *((unsigned int *)t147) = t156;
    t157 = (t0 + 2328U);
    t158 = *((char **)t157);
    memset(t159, 0, 8);
    t157 = (t159 + 4);
    t160 = (t158 + 4);
    t161 = *((unsigned int *)t158);
    t162 = (t161 >> 1);
    t163 = (t162 & 1);
    *((unsigned int *)t159) = t163;
    t164 = *((unsigned int *)t160);
    t165 = (t164 >> 1);
    t166 = (t165 & 1);
    *((unsigned int *)t157) = t166;
    t168 = *((unsigned int *)t149);
    t169 = *((unsigned int *)t159);
    t170 = (t168 | t169);
    *((unsigned int *)t167) = t170;
    t171 = (t149 + 4);
    t172 = (t159 + 4);
    t173 = (t167 + 4);
    t174 = *((unsigned int *)t171);
    t175 = *((unsigned int *)t172);
    t176 = (t174 | t175);
    *((unsigned int *)t173) = t176;
    t177 = *((unsigned int *)t173);
    t178 = (t177 != 0);
    if (t178 == 1)
        goto LAB13;

LAB14:
LAB15:    t195 = (t0 + 2488U);
    t196 = *((char **)t195);
    memset(t197, 0, 8);
    t195 = (t197 + 4);
    t198 = (t196 + 4);
    t199 = *((unsigned int *)t196);
    t200 = (t199 >> 0);
    t201 = (t200 & 1);
    *((unsigned int *)t197) = t201;
    t202 = *((unsigned int *)t198);
    t203 = (t202 >> 0);
    t204 = (t203 & 1);
    *((unsigned int *)t195) = t204;
    t205 = (t0 + 2488U);
    t206 = *((char **)t205);
    memset(t207, 0, 8);
    t205 = (t207 + 4);
    t208 = (t206 + 4);
    t209 = *((unsigned int *)t206);
    t210 = (t209 >> 1);
    t211 = (t210 & 1);
    *((unsigned int *)t207) = t211;
    t212 = *((unsigned int *)t208);
    t213 = (t212 >> 1);
    t214 = (t213 & 1);
    *((unsigned int *)t205) = t214;
    t216 = *((unsigned int *)t197);
    t217 = *((unsigned int *)t207);
    t218 = (t216 | t217);
    *((unsigned int *)t215) = t218;
    t219 = (t197 + 4);
    t220 = (t207 + 4);
    t221 = (t215 + 4);
    t222 = *((unsigned int *)t219);
    t223 = *((unsigned int *)t220);
    t224 = (t222 | t223);
    *((unsigned int *)t221) = t224;
    t225 = *((unsigned int *)t221);
    t226 = (t225 != 0);
    if (t226 == 1)
        goto LAB16;

LAB17:
LAB18:    t243 = (t0 + 2648U);
    t244 = *((char **)t243);
    memset(t245, 0, 8);
    t243 = (t245 + 4);
    t246 = (t244 + 4);
    t247 = *((unsigned int *)t244);
    t248 = (t247 >> 0);
    t249 = (t248 & 1);
    *((unsigned int *)t245) = t249;
    t250 = *((unsigned int *)t246);
    t251 = (t250 >> 0);
    t252 = (t251 & 1);
    *((unsigned int *)t243) = t252;
    t253 = (t0 + 2648U);
    t254 = *((char **)t253);
    memset(t255, 0, 8);
    t253 = (t255 + 4);
    t256 = (t254 + 4);
    t257 = *((unsigned int *)t254);
    t258 = (t257 >> 1);
    t259 = (t258 & 1);
    *((unsigned int *)t255) = t259;
    t260 = *((unsigned int *)t256);
    t261 = (t260 >> 1);
    t262 = (t261 & 1);
    *((unsigned int *)t253) = t262;
    t264 = *((unsigned int *)t245);
    t265 = *((unsigned int *)t255);
    t266 = (t264 | t265);
    *((unsigned int *)t263) = t266;
    t267 = (t245 + 4);
    t268 = (t255 + 4);
    t269 = (t263 + 4);
    t270 = *((unsigned int *)t267);
    t271 = *((unsigned int *)t268);
    t272 = (t270 | t271);
    *((unsigned int *)t269) = t272;
    t273 = *((unsigned int *)t269);
    t274 = (t273 != 0);
    if (t274 == 1)
        goto LAB19;

LAB20:
LAB21:    t291 = (t0 + 2808U);
    t292 = *((char **)t291);
    memset(t293, 0, 8);
    t291 = (t293 + 4);
    t294 = (t292 + 4);
    t295 = *((unsigned int *)t292);
    t296 = (t295 >> 0);
    t297 = (t296 & 1);
    *((unsigned int *)t293) = t297;
    t298 = *((unsigned int *)t294);
    t299 = (t298 >> 0);
    t300 = (t299 & 1);
    *((unsigned int *)t291) = t300;
    t301 = (t0 + 2808U);
    t302 = *((char **)t301);
    memset(t303, 0, 8);
    t301 = (t303 + 4);
    t304 = (t302 + 4);
    t305 = *((unsigned int *)t302);
    t306 = (t305 >> 1);
    t307 = (t306 & 1);
    *((unsigned int *)t303) = t307;
    t308 = *((unsigned int *)t304);
    t309 = (t308 >> 1);
    t310 = (t309 & 1);
    *((unsigned int *)t301) = t310;
    t312 = *((unsigned int *)t293);
    t313 = *((unsigned int *)t303);
    t314 = (t312 | t313);
    *((unsigned int *)t311) = t314;
    t315 = (t293 + 4);
    t316 = (t303 + 4);
    t317 = (t311 + 4);
    t318 = *((unsigned int *)t315);
    t319 = *((unsigned int *)t316);
    t320 = (t318 | t319);
    *((unsigned int *)t317) = t320;
    t321 = *((unsigned int *)t317);
    t322 = (t321 != 0);
    if (t322 == 1)
        goto LAB22;

LAB23:
LAB24:    t339 = (t0 + 2968U);
    t340 = *((char **)t339);
    memset(t341, 0, 8);
    t339 = (t341 + 4);
    t342 = (t340 + 4);
    t343 = *((unsigned int *)t340);
    t344 = (t343 >> 0);
    t345 = (t344 & 1);
    *((unsigned int *)t341) = t345;
    t346 = *((unsigned int *)t342);
    t347 = (t346 >> 0);
    t348 = (t347 & 1);
    *((unsigned int *)t339) = t348;
    t349 = (t0 + 2968U);
    t350 = *((char **)t349);
    memset(t351, 0, 8);
    t349 = (t351 + 4);
    t352 = (t350 + 4);
    t353 = *((unsigned int *)t350);
    t354 = (t353 >> 1);
    t355 = (t354 & 1);
    *((unsigned int *)t351) = t355;
    t356 = *((unsigned int *)t352);
    t357 = (t356 >> 1);
    t358 = (t357 & 1);
    *((unsigned int *)t349) = t358;
    t360 = *((unsigned int *)t341);
    t361 = *((unsigned int *)t351);
    t362 = (t360 | t361);
    *((unsigned int *)t359) = t362;
    t363 = (t341 + 4);
    t364 = (t351 + 4);
    t365 = (t359 + 4);
    t366 = *((unsigned int *)t363);
    t367 = *((unsigned int *)t364);
    t368 = (t366 | t367);
    *((unsigned int *)t365) = t368;
    t369 = *((unsigned int *)t365);
    t370 = (t369 != 0);
    if (t370 == 1)
        goto LAB25;

LAB26:
LAB27:    xsi_vlogtype_concat(t3, 8, 8, 8U, t359, 1, t311, 1, t263, 1, t215, 1, t167, 1, t119, 1, t71, 1, t23, 1);
    t387 = (t0 + 5696);
    t388 = (t387 + 56U);
    t389 = *((char **)t388);
    t390 = (t389 + 56U);
    t391 = *((char **)t390);
    memset(t391, 0, 8);
    t392 = 255U;
    t393 = t392;
    t394 = (t3 + 4);
    t395 = *((unsigned int *)t3);
    t392 = (t392 & t395);
    t396 = *((unsigned int *)t394);
    t393 = (t393 & t396);
    t397 = (t391 + 4);
    t398 = *((unsigned int *)t391);
    *((unsigned int *)t391) = (t398 | t392);
    t399 = *((unsigned int *)t397);
    *((unsigned int *)t397) = (t399 | t393);
    xsi_driver_vfirst_trans(t387, 0, 7U);
    t400 = (t0 + 5584);
    *((int *)t400) = 1;

LAB1:    return;
LAB4:    t35 = *((unsigned int *)t23);
    t36 = *((unsigned int *)t29);
    *((unsigned int *)t23) = (t35 | t36);
    t37 = (t5 + 4);
    t38 = (t15 + 4);
    t39 = *((unsigned int *)t37);
    t40 = (~(t39));
    t41 = *((unsigned int *)t5);
    t42 = (t41 & t40);
    t43 = *((unsigned int *)t38);
    t44 = (~(t43));
    t45 = *((unsigned int *)t15);
    t46 = (t45 & t44);
    t47 = (~(t42));
    t48 = (~(t46));
    t49 = *((unsigned int *)t29);
    *((unsigned int *)t29) = (t49 & t47);
    t50 = *((unsigned int *)t29);
    *((unsigned int *)t29) = (t50 & t48);
    goto LAB6;

LAB7:    t83 = *((unsigned int *)t71);
    t84 = *((unsigned int *)t77);
    *((unsigned int *)t71) = (t83 | t84);
    t85 = (t53 + 4);
    t86 = (t63 + 4);
    t87 = *((unsigned int *)t85);
    t88 = (~(t87));
    t89 = *((unsigned int *)t53);
    t90 = (t89 & t88);
    t91 = *((unsigned int *)t86);
    t92 = (~(t91));
    t93 = *((unsigned int *)t63);
    t94 = (t93 & t92);
    t95 = (~(t90));
    t96 = (~(t94));
    t97 = *((unsigned int *)t77);
    *((unsigned int *)t77) = (t97 & t95);
    t98 = *((unsigned int *)t77);
    *((unsigned int *)t77) = (t98 & t96);
    goto LAB9;

LAB10:    t131 = *((unsigned int *)t119);
    t132 = *((unsigned int *)t125);
    *((unsigned int *)t119) = (t131 | t132);
    t133 = (t101 + 4);
    t134 = (t111 + 4);
    t135 = *((unsigned int *)t133);
    t136 = (~(t135));
    t137 = *((unsigned int *)t101);
    t138 = (t137 & t136);
    t139 = *((unsigned int *)t134);
    t140 = (~(t139));
    t141 = *((unsigned int *)t111);
    t142 = (t141 & t140);
    t143 = (~(t138));
    t144 = (~(t142));
    t145 = *((unsigned int *)t125);
    *((unsigned int *)t125) = (t145 & t143);
    t146 = *((unsigned int *)t125);
    *((unsigned int *)t125) = (t146 & t144);
    goto LAB12;

LAB13:    t179 = *((unsigned int *)t167);
    t180 = *((unsigned int *)t173);
    *((unsigned int *)t167) = (t179 | t180);
    t181 = (t149 + 4);
    t182 = (t159 + 4);
    t183 = *((unsigned int *)t181);
    t184 = (~(t183));
    t185 = *((unsigned int *)t149);
    t186 = (t185 & t184);
    t187 = *((unsigned int *)t182);
    t188 = (~(t187));
    t189 = *((unsigned int *)t159);
    t190 = (t189 & t188);
    t191 = (~(t186));
    t192 = (~(t190));
    t193 = *((unsigned int *)t173);
    *((unsigned int *)t173) = (t193 & t191);
    t194 = *((unsigned int *)t173);
    *((unsigned int *)t173) = (t194 & t192);
    goto LAB15;

LAB16:    t227 = *((unsigned int *)t215);
    t228 = *((unsigned int *)t221);
    *((unsigned int *)t215) = (t227 | t228);
    t229 = (t197 + 4);
    t230 = (t207 + 4);
    t231 = *((unsigned int *)t229);
    t232 = (~(t231));
    t233 = *((unsigned int *)t197);
    t234 = (t233 & t232);
    t235 = *((unsigned int *)t230);
    t236 = (~(t235));
    t237 = *((unsigned int *)t207);
    t238 = (t237 & t236);
    t239 = (~(t234));
    t240 = (~(t238));
    t241 = *((unsigned int *)t221);
    *((unsigned int *)t221) = (t241 & t239);
    t242 = *((unsigned int *)t221);
    *((unsigned int *)t221) = (t242 & t240);
    goto LAB18;

LAB19:    t275 = *((unsigned int *)t263);
    t276 = *((unsigned int *)t269);
    *((unsigned int *)t263) = (t275 | t276);
    t277 = (t245 + 4);
    t278 = (t255 + 4);
    t279 = *((unsigned int *)t277);
    t280 = (~(t279));
    t281 = *((unsigned int *)t245);
    t282 = (t281 & t280);
    t283 = *((unsigned int *)t278);
    t284 = (~(t283));
    t285 = *((unsigned int *)t255);
    t286 = (t285 & t284);
    t287 = (~(t282));
    t288 = (~(t286));
    t289 = *((unsigned int *)t269);
    *((unsigned int *)t269) = (t289 & t287);
    t290 = *((unsigned int *)t269);
    *((unsigned int *)t269) = (t290 & t288);
    goto LAB21;

LAB22:    t323 = *((unsigned int *)t311);
    t324 = *((unsigned int *)t317);
    *((unsigned int *)t311) = (t323 | t324);
    t325 = (t293 + 4);
    t326 = (t303 + 4);
    t327 = *((unsigned int *)t325);
    t328 = (~(t327));
    t329 = *((unsigned int *)t293);
    t330 = (t329 & t328);
    t331 = *((unsigned int *)t326);
    t332 = (~(t331));
    t333 = *((unsigned int *)t303);
    t334 = (t333 & t332);
    t335 = (~(t330));
    t336 = (~(t334));
    t337 = *((unsigned int *)t317);
    *((unsigned int *)t317) = (t337 & t335);
    t338 = *((unsigned int *)t317);
    *((unsigned int *)t317) = (t338 & t336);
    goto LAB24;

LAB25:    t371 = *((unsigned int *)t359);
    t372 = *((unsigned int *)t365);
    *((unsigned int *)t359) = (t371 | t372);
    t373 = (t341 + 4);
    t374 = (t351 + 4);
    t375 = *((unsigned int *)t373);
    t376 = (~(t375));
    t377 = *((unsigned int *)t341);
    t378 = (t377 & t376);
    t379 = *((unsigned int *)t374);
    t380 = (~(t379));
    t381 = *((unsigned int *)t351);
    t382 = (t381 & t380);
    t383 = (~(t378));
    t384 = (~(t382));
    t385 = *((unsigned int *)t365);
    *((unsigned int *)t365) = (t385 & t383);
    t386 = *((unsigned int *)t365);
    *((unsigned int *)t365) = (t386 & t384);
    goto LAB27;

}

static void Always_66_1(char *t0)
{
    char t13[8];
    char t22[8];
    char t40[8];
    char t54[8];
    char t61[8];
    char t93[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    char *t53;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    char *t65;
    char *t66;
    char *t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    int t85;
    int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    char *t97;
    char *t98;
    char *t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    char *t107;
    char *t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    char *t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    char *t127;
    char *t128;

LAB0:    t1 = (t0 + 5016U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 5600);
    *((int *)t2) = 1;
    t3 = (t0 + 5048);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(67, ng0);

LAB5:    xsi_set_current_line(68, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(71, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    memset(t13, 0, 8);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB12;

LAB10:    if (*((unsigned int *)t2) == 0)
        goto LAB9;

LAB11:    t4 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t4) = 1;

LAB12:    t5 = (t13 + 4);
    t11 = (t3 + 4);
    t14 = *((unsigned int *)t3);
    t15 = (~(t14));
    *((unsigned int *)t13) = t15;
    *((unsigned int *)t5) = 0;
    if (*((unsigned int *)t11) != 0)
        goto LAB14;

LAB13:    t20 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t20 & 1U);
    t21 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t21 & 1U);
    t12 = (t0 + 1528U);
    t23 = *((char **)t12);
    memset(t22, 0, 8);
    t12 = (t23 + 4);
    t24 = *((unsigned int *)t12);
    t25 = (~(t24));
    t26 = *((unsigned int *)t23);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB18;

LAB16:    if (*((unsigned int *)t12) == 0)
        goto LAB15;

LAB17:    t29 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t29) = 1;

LAB18:    t30 = (t22 + 4);
    t31 = (t23 + 4);
    t32 = *((unsigned int *)t23);
    t33 = (~(t32));
    *((unsigned int *)t22) = t33;
    *((unsigned int *)t30) = 0;
    if (*((unsigned int *)t31) != 0)
        goto LAB20;

LAB19:    t38 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t38 & 1U);
    t39 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t39 & 1U);
    memset(t40, 0, 8);
    t41 = (t22 + 4);
    t42 = *((unsigned int *)t41);
    t43 = (~(t42));
    t44 = *((unsigned int *)t22);
    t45 = (t44 & t43);
    t46 = (t45 & 1U);
    if (t46 != 0)
        goto LAB21;

LAB22:    if (*((unsigned int *)t41) != 0)
        goto LAB23;

LAB24:    t48 = (t40 + 4);
    t49 = *((unsigned int *)t40);
    t50 = *((unsigned int *)t48);
    t51 = (t49 || t50);
    if (t51 > 0)
        goto LAB25;

LAB26:    memcpy(t61, t40, 8);

LAB27:    t94 = *((unsigned int *)t13);
    t95 = *((unsigned int *)t61);
    t96 = (t94 | t95);
    *((unsigned int *)t93) = t96;
    t97 = (t13 + 4);
    t98 = (t61 + 4);
    t99 = (t93 + 4);
    t100 = *((unsigned int *)t97);
    t101 = *((unsigned int *)t98);
    t102 = (t100 | t101);
    *((unsigned int *)t99) = t102;
    t103 = *((unsigned int *)t99);
    t104 = (t103 != 0);
    if (t104 == 1)
        goto LAB35;

LAB36:
LAB37:    t121 = (t93 + 4);
    t122 = *((unsigned int *)t121);
    t123 = (~(t122));
    t124 = *((unsigned int *)t93);
    t125 = (t124 & t123);
    t126 = (t125 != 0);
    if (t126 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 3288U);
    t3 = *((char **)t2);

LAB41:    t2 = ((char*)((ng2)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB42;

LAB43:    t2 = ((char*)((ng3)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng4)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB46;

LAB47:    t2 = ((char*)((ng5)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB48;

LAB49:    t2 = ((char*)((ng6)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB50;

LAB51:    t2 = ((char*)((ng7)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB52;

LAB53:    t2 = ((char*)((ng8)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB54;

LAB55:    t2 = ((char*)((ng9)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB56;

LAB57:
LAB59:
LAB58:    xsi_set_current_line(83, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 4, 0LL);

LAB60:
LAB40:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(69, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 4, 0LL);
    goto LAB8;

LAB9:    *((unsigned int *)t13) = 1;
    goto LAB12;

LAB14:    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t11);
    *((unsigned int *)t13) = (t16 | t17);
    t18 = *((unsigned int *)t5);
    t19 = *((unsigned int *)t11);
    *((unsigned int *)t5) = (t18 | t19);
    goto LAB13;

LAB15:    *((unsigned int *)t22) = 1;
    goto LAB18;

LAB20:    t34 = *((unsigned int *)t22);
    t35 = *((unsigned int *)t31);
    *((unsigned int *)t22) = (t34 | t35);
    t36 = *((unsigned int *)t30);
    t37 = *((unsigned int *)t31);
    *((unsigned int *)t30) = (t36 | t37);
    goto LAB19;

LAB21:    *((unsigned int *)t40) = 1;
    goto LAB24;

LAB23:    t47 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB24;

LAB25:    t52 = (t0 + 1688U);
    t53 = *((char **)t52);
    memset(t54, 0, 8);
    t52 = (t53 + 4);
    t55 = *((unsigned int *)t52);
    t56 = (~(t55));
    t57 = *((unsigned int *)t53);
    t58 = (t57 & t56);
    t59 = (t58 & 1U);
    if (t59 != 0)
        goto LAB28;

LAB29:    if (*((unsigned int *)t52) != 0)
        goto LAB30;

LAB31:    t62 = *((unsigned int *)t40);
    t63 = *((unsigned int *)t54);
    t64 = (t62 & t63);
    *((unsigned int *)t61) = t64;
    t65 = (t40 + 4);
    t66 = (t54 + 4);
    t67 = (t61 + 4);
    t68 = *((unsigned int *)t65);
    t69 = *((unsigned int *)t66);
    t70 = (t68 | t69);
    *((unsigned int *)t67) = t70;
    t71 = *((unsigned int *)t67);
    t72 = (t71 != 0);
    if (t72 == 1)
        goto LAB32;

LAB33:
LAB34:    goto LAB27;

LAB28:    *((unsigned int *)t54) = 1;
    goto LAB31;

LAB30:    t60 = (t54 + 4);
    *((unsigned int *)t54) = 1;
    *((unsigned int *)t60) = 1;
    goto LAB31;

LAB32:    t73 = *((unsigned int *)t61);
    t74 = *((unsigned int *)t67);
    *((unsigned int *)t61) = (t73 | t74);
    t75 = (t40 + 4);
    t76 = (t54 + 4);
    t77 = *((unsigned int *)t40);
    t78 = (~(t77));
    t79 = *((unsigned int *)t75);
    t80 = (~(t79));
    t81 = *((unsigned int *)t54);
    t82 = (~(t81));
    t83 = *((unsigned int *)t76);
    t84 = (~(t83));
    t85 = (t78 & t80);
    t86 = (t82 & t84);
    t87 = (~(t85));
    t88 = (~(t86));
    t89 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t89 & t87);
    t90 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t90 & t88);
    t91 = *((unsigned int *)t61);
    *((unsigned int *)t61) = (t91 & t87);
    t92 = *((unsigned int *)t61);
    *((unsigned int *)t61) = (t92 & t88);
    goto LAB34;

LAB35:    t105 = *((unsigned int *)t93);
    t106 = *((unsigned int *)t99);
    *((unsigned int *)t93) = (t105 | t106);
    t107 = (t13 + 4);
    t108 = (t61 + 4);
    t109 = *((unsigned int *)t107);
    t110 = (~(t109));
    t111 = *((unsigned int *)t13);
    t112 = (t111 & t110);
    t113 = *((unsigned int *)t108);
    t114 = (~(t113));
    t115 = *((unsigned int *)t61);
    t116 = (t115 & t114);
    t117 = (~(t112));
    t118 = (~(t116));
    t119 = *((unsigned int *)t99);
    *((unsigned int *)t99) = (t119 & t117);
    t120 = *((unsigned int *)t99);
    *((unsigned int *)t99) = (t120 & t118);
    goto LAB37;

LAB38:    xsi_set_current_line(72, ng0);
    t127 = ((char*)((ng1)));
    t128 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t128, t127, 0, 0, 4, 0LL);
    goto LAB40;

LAB42:    xsi_set_current_line(75, ng0);
    t4 = (t0 + 1848U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB44:    xsi_set_current_line(76, ng0);
    t4 = (t0 + 2008U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB46:    xsi_set_current_line(77, ng0);
    t4 = (t0 + 2168U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB48:    xsi_set_current_line(78, ng0);
    t4 = (t0 + 2328U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB50:    xsi_set_current_line(79, ng0);
    t4 = (t0 + 2488U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB52:    xsi_set_current_line(80, ng0);
    t4 = (t0 + 2648U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB54:    xsi_set_current_line(81, ng0);
    t4 = (t0 + 2808U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

LAB56:    xsi_set_current_line(82, ng0);
    t4 = (t0 + 2968U);
    t5 = *((char **)t4);
    t4 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 4, 0LL);
    goto LAB60;

}

static void Always_87_2(char *t0)
{
    char t13[8];
    char t22[8];
    char t40[8];
    char t54[8];
    char t61[8];
    char t93[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    char *t53;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    char *t65;
    char *t66;
    char *t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    int t85;
    int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    char *t97;
    char *t98;
    char *t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    char *t107;
    char *t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    char *t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    char *t127;
    char *t128;

LAB0:    t1 = (t0 + 5264U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(87, ng0);
    t2 = (t0 + 5616);
    *((int *)t2) = 1;
    t3 = (t0 + 5296);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(88, ng0);

LAB5:    xsi_set_current_line(89, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    memset(t13, 0, 8);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB12;

LAB10:    if (*((unsigned int *)t2) == 0)
        goto LAB9;

LAB11:    t4 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t4) = 1;

LAB12:    t5 = (t13 + 4);
    t11 = (t3 + 4);
    t14 = *((unsigned int *)t3);
    t15 = (~(t14));
    *((unsigned int *)t13) = t15;
    *((unsigned int *)t5) = 0;
    if (*((unsigned int *)t11) != 0)
        goto LAB14;

LAB13:    t20 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t20 & 1U);
    t21 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t21 & 1U);
    t12 = (t0 + 1528U);
    t23 = *((char **)t12);
    memset(t22, 0, 8);
    t12 = (t23 + 4);
    t24 = *((unsigned int *)t12);
    t25 = (~(t24));
    t26 = *((unsigned int *)t23);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB18;

LAB16:    if (*((unsigned int *)t12) == 0)
        goto LAB15;

LAB17:    t29 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t29) = 1;

LAB18:    t30 = (t22 + 4);
    t31 = (t23 + 4);
    t32 = *((unsigned int *)t23);
    t33 = (~(t32));
    *((unsigned int *)t22) = t33;
    *((unsigned int *)t30) = 0;
    if (*((unsigned int *)t31) != 0)
        goto LAB20;

LAB19:    t38 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t38 & 1U);
    t39 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t39 & 1U);
    memset(t40, 0, 8);
    t41 = (t22 + 4);
    t42 = *((unsigned int *)t41);
    t43 = (~(t42));
    t44 = *((unsigned int *)t22);
    t45 = (t44 & t43);
    t46 = (t45 & 1U);
    if (t46 != 0)
        goto LAB21;

LAB22:    if (*((unsigned int *)t41) != 0)
        goto LAB23;

LAB24:    t48 = (t40 + 4);
    t49 = *((unsigned int *)t40);
    t50 = *((unsigned int *)t48);
    t51 = (t49 || t50);
    if (t51 > 0)
        goto LAB25;

LAB26:    memcpy(t61, t40, 8);

LAB27:    t94 = *((unsigned int *)t13);
    t95 = *((unsigned int *)t61);
    t96 = (t94 | t95);
    *((unsigned int *)t93) = t96;
    t97 = (t13 + 4);
    t98 = (t61 + 4);
    t99 = (t93 + 4);
    t100 = *((unsigned int *)t97);
    t101 = *((unsigned int *)t98);
    t102 = (t100 | t101);
    *((unsigned int *)t99) = t102;
    t103 = *((unsigned int *)t99);
    t104 = (t103 != 0);
    if (t104 == 1)
        goto LAB35;

LAB36:
LAB37:    t121 = (t93 + 4);
    t122 = *((unsigned int *)t121);
    t123 = (~(t122));
    t124 = *((unsigned int *)t93);
    t125 = (t124 & t123);
    t126 = (t125 != 0);
    if (t126 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(95, ng0);
    t2 = (t0 + 3288U);
    t3 = *((char **)t2);

LAB41:    t2 = ((char*)((ng2)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB42;

LAB43:    t2 = ((char*)((ng3)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng4)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB46;

LAB47:    t2 = ((char*)((ng5)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB48;

LAB49:    t2 = ((char*)((ng6)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB50;

LAB51:    t2 = ((char*)((ng7)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB52;

LAB53:    t2 = ((char*)((ng8)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB54;

LAB55:    t2 = ((char*)((ng9)));
    t85 = xsi_vlog_unsigned_case_xcompare(t3, 8, t2, 8);
    if (t85 == 1)
        goto LAB56;

LAB57:
LAB59:
LAB58:    xsi_set_current_line(104, ng0);
    t2 = ((char*)((ng10)));
    t4 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);

LAB60:
LAB40:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(90, ng0);
    t11 = ((char*)((ng10)));
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 1, 0LL);
    goto LAB8;

LAB9:    *((unsigned int *)t13) = 1;
    goto LAB12;

LAB14:    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t11);
    *((unsigned int *)t13) = (t16 | t17);
    t18 = *((unsigned int *)t5);
    t19 = *((unsigned int *)t11);
    *((unsigned int *)t5) = (t18 | t19);
    goto LAB13;

LAB15:    *((unsigned int *)t22) = 1;
    goto LAB18;

LAB20:    t34 = *((unsigned int *)t22);
    t35 = *((unsigned int *)t31);
    *((unsigned int *)t22) = (t34 | t35);
    t36 = *((unsigned int *)t30);
    t37 = *((unsigned int *)t31);
    *((unsigned int *)t30) = (t36 | t37);
    goto LAB19;

LAB21:    *((unsigned int *)t40) = 1;
    goto LAB24;

LAB23:    t47 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB24;

LAB25:    t52 = (t0 + 1688U);
    t53 = *((char **)t52);
    memset(t54, 0, 8);
    t52 = (t53 + 4);
    t55 = *((unsigned int *)t52);
    t56 = (~(t55));
    t57 = *((unsigned int *)t53);
    t58 = (t57 & t56);
    t59 = (t58 & 1U);
    if (t59 != 0)
        goto LAB28;

LAB29:    if (*((unsigned int *)t52) != 0)
        goto LAB30;

LAB31:    t62 = *((unsigned int *)t40);
    t63 = *((unsigned int *)t54);
    t64 = (t62 & t63);
    *((unsigned int *)t61) = t64;
    t65 = (t40 + 4);
    t66 = (t54 + 4);
    t67 = (t61 + 4);
    t68 = *((unsigned int *)t65);
    t69 = *((unsigned int *)t66);
    t70 = (t68 | t69);
    *((unsigned int *)t67) = t70;
    t71 = *((unsigned int *)t67);
    t72 = (t71 != 0);
    if (t72 == 1)
        goto LAB32;

LAB33:
LAB34:    goto LAB27;

LAB28:    *((unsigned int *)t54) = 1;
    goto LAB31;

LAB30:    t60 = (t54 + 4);
    *((unsigned int *)t54) = 1;
    *((unsigned int *)t60) = 1;
    goto LAB31;

LAB32:    t73 = *((unsigned int *)t61);
    t74 = *((unsigned int *)t67);
    *((unsigned int *)t61) = (t73 | t74);
    t75 = (t40 + 4);
    t76 = (t54 + 4);
    t77 = *((unsigned int *)t40);
    t78 = (~(t77));
    t79 = *((unsigned int *)t75);
    t80 = (~(t79));
    t81 = *((unsigned int *)t54);
    t82 = (~(t81));
    t83 = *((unsigned int *)t76);
    t84 = (~(t83));
    t85 = (t78 & t80);
    t86 = (t82 & t84);
    t87 = (~(t85));
    t88 = (~(t86));
    t89 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t89 & t87);
    t90 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t90 & t88);
    t91 = *((unsigned int *)t61);
    *((unsigned int *)t61) = (t91 & t87);
    t92 = *((unsigned int *)t61);
    *((unsigned int *)t61) = (t92 & t88);
    goto LAB34;

LAB35:    t105 = *((unsigned int *)t93);
    t106 = *((unsigned int *)t99);
    *((unsigned int *)t93) = (t105 | t106);
    t107 = (t13 + 4);
    t108 = (t61 + 4);
    t109 = *((unsigned int *)t107);
    t110 = (~(t109));
    t111 = *((unsigned int *)t13);
    t112 = (t111 & t110);
    t113 = *((unsigned int *)t108);
    t114 = (~(t113));
    t115 = *((unsigned int *)t61);
    t116 = (t115 & t114);
    t117 = (~(t112));
    t118 = (~(t116));
    t119 = *((unsigned int *)t99);
    *((unsigned int *)t99) = (t119 & t117);
    t120 = *((unsigned int *)t99);
    *((unsigned int *)t99) = (t120 & t118);
    goto LAB37;

LAB38:    xsi_set_current_line(93, ng0);
    t127 = ((char*)((ng10)));
    t128 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t128, t127, 0, 0, 1, 0LL);
    goto LAB40;

LAB42:    xsi_set_current_line(96, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 0);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 0);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB44:    xsi_set_current_line(97, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 1);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 1);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB46:    xsi_set_current_line(98, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 2);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 2);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB48:    xsi_set_current_line(99, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 3);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 3);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB50:    xsi_set_current_line(100, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 4);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 4);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB52:    xsi_set_current_line(101, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 5);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 5);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB54:    xsi_set_current_line(102, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 6);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 6);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

LAB56:    xsi_set_current_line(103, ng0);
    t4 = (t0 + 3128U);
    t5 = *((char **)t4);
    memset(t13, 0, 8);
    t4 = (t13 + 4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (t6 >> 7);
    t8 = (t7 & 1);
    *((unsigned int *)t13) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 7);
    t14 = (t10 & 1);
    *((unsigned int *)t4) = t14;
    t12 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t12, t13, 0, 0, 1, 0LL);
    goto LAB60;

}


extern void work_m_00000000004275124887_0338851468_init()
{
	static char *pe[] = {(void *)NetDecl_57_0,(void *)Always_66_1,(void *)Always_87_2};
	xsi_register_didat("work_m_00000000004275124887_0338851468", "isim/nes_top_test_isim_beh.exe.sim/work/m_00000000004275124887_0338851468.didat");
	xsi_register_executes(pe);
}
