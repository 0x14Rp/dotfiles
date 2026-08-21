import sys
ARCH=("m127.98 12.07c-10.316 25.309-16.543 41.855-28.031 66.41 7.043 7.4609 15.691 16.156 29.734 25.977-15.098-6.207-25.395-12.445-33.094-18.918"
"-14.703 30.68-37.742 74.391-84.492 158.39 36.746-21.219 65.23-34.293 91.773-39.289-1.1406-4.8945-1.7852-10.195-1.7422-15.734l0.042969-1.1719"
"c0.58203-23.551 12.828-41.645 27.336-40.418 14.508 1.2266 25.781 21.316 25.199 44.867-0.10938 4.4219-0.60938 8.6914-1.4805 12.641 26.258 5.1328 54.438 18.18 90.684 39.105"
"-7.1484-13.156-13.527-25.016-19.621-36.316-9.5938-7.4336-19.605-17.117-40.023-27.594 14.035 3.6406 24.082 7.8516 31.914 12.555-61.941-115.32-66.957-130.66-88.199-180.5z")
L={'PG':(-0.3681,190.24),'IP':(+0.0789,71.09),'BI':(+0.6524,-57.46)}
def hp(a,b): return f"{a*-300+b:.2f},-300 {a*600+b:.2f},600 -900,600 -900,-300"
def build(bw, color, pad):
    M=pad
    return f'''<svg version="1.1" viewBox="{-M} {-M} {256+2*M} {256+2*M}" xmlns="http://www.w3.org/2000/svg">
  <defs><clipPath id="a"><path d="{ARCH}" fill-rule="evenodd"/></clipPath></defs>
  <!-- contorno: trazo grueso DEBAJO; el relleno tapa su mitad interior -->
  <path d="{ARCH}" fill-rule="evenodd" fill="none" stroke="{color}"
        stroke-width="{bw*2}" stroke-linejoin="round" stroke-linecap="round"/>
  <g clip-path="url(#a)">
    <rect x="-900" y="-300" width="2000" height="1200" fill="#6C7086"/>
    <polygon points="{hp(*L['PG'])}" fill="#EBBCBA"/>
    <polygon points="{hp(*L['IP'])}" fill="#C79BF0"/>
    <polygon points="{hp(*L['BI'])}" fill="#A9B1D6"/>
  </g>
</svg>'''
if __name__=='__main__':
    bw=float(sys.argv[1]); col=sys.argv[2]; out=sys.argv[3]
    open(out,'w').write(build(bw,col,bw+2))
