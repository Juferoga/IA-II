imgs = [[-2.73,-2.73,-2.83,-3.54],[0.73,-0.73,0,0.71]]

def alpha(imgs):
  xp1 = imgs[0]
  xp2 = imgs[1]
  return xp1[2]*xp2[1]-xp2[2]*xp1[1]/xp1[3]*xp2[2]-xp2[2]*xp1[1]

print(alpha(imgs))
