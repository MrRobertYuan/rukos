typedef unsigned long long uint64_t;
typedef long uintptr_t;
typedef long size_t;

void __clear_cache(void *start, void *end) {
  uint64_t xstart = (uint64_t)(uintptr_t) start;
  uint64_t xend = (uint64_t)(uintptr_t) end;
  // Get Cache Type Info
  uint64_t ctr_el0;
  __asm __volatile("mrs %0, ctr_el0" : "=r"(ctr_el0));
  /*
   * dc & ic instructions must use 64bit registers so we don't use
   * uintptr_t in case this runs in an IPL32 environment.
   */
  const size_t dcache_line_size = 4 << ((ctr_el0 >> 16) & 15);
  for (uint64_t addr = xstart; addr < xend; addr += dcache_line_size)
    __asm __volatile("dc cvau, %0" :: "r"(addr));
  __asm __volatile("dsb ish");
  const size_t icache_line_size = 4 << ((ctr_el0 >> 0) & 15);
  for (uint64_t addr = xstart; addr < xend; addr += icache_line_size)
    __asm __volatile("ic ivau, %0" :: "r"(addr));
  __asm __volatile("isb sy");
}