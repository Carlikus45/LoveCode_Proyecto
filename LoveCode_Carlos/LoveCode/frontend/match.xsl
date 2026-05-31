<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/match">
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>LoveCode — Ficha de Match</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&amp;display=swap" rel="stylesheet"/>
  <style>
    body {
      background-color: #cc0000;
      font-family: 'Poppins', sans-serif;
      color: white;
      padding: 30px;
      margin: 0;
    }
    h1 { text-align: center; font-size: 28px; }
    .fecha { text-align: center; font-size: 13px; opacity: 0.8; margin-bottom: 24px; }
    .fila { display: flex; gap: 16px; justify-content: center; flex-wrap: wrap; margin-bottom: 20px; }
    .usuario {
      background: white; color: #333;
      border-radius: 10px; padding: 20px;
      width: 200px; text-align: center;
    }
    .usuario h3 { color: #cc0000; margin: 0 0 8px; font-size: 16px; }
    .usuario p  { font-size: 12px; color: #666; margin: 0 0 8px; }
    .usuario .tecs { font-size: 11px; color: #999; }
    .comunes {
      background: white; color: #333;
      border-radius: 10px; padding: 16px;
      max-width: 440px; margin: 0 auto; text-align: center;
    }
    .comunes h3 { color: #cc0000; margin: 0 0 8px; }
    a {
      display: block; text-align: center; margin-top: 20px;
      color: white; font-size: 14px;
    }
  </style>
</head>
<body>
  <h1>¡Es un Match! ❤️</h1>
  <p class="fecha">Fecha: <xsl:value-of select="fecha"/></p>

  <div class="fila">
    <div class="usuario">
      <h3><xsl:value-of select="usuario1/nombre"/></h3>
      <p><xsl:value-of select="usuario1/descripcion"/></p>
      <p class="tecs">
        <xsl:for-each select="usuario1/tecnologias/tecnologia">
          <xsl:value-of select="."/><xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
      </p>
    </div>
    <div class="usuario">
      <h3><xsl:value-of select="usuario2/nombre"/></h3>
      <p><xsl:value-of select="usuario2/descripcion"/></p>
      <p class="tecs">
        <xsl:for-each select="usuario2/tecnologias/tecnologia">
          <xsl:value-of select="."/><xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
      </p>
    </div>
  </div>

  <div class="comunes">
    <h3>Tecnologías en común</h3>
    <xsl:choose>
      <xsl:when test="tecnologias_comunes/tecnologia">
        <p>
          <xsl:for-each select="tecnologias_comunes/tecnologia">
            <xsl:value-of select="."/><xsl:if test="position() != last()">, </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p style="color:#999;">Ninguna tecnología en común de momento</p>
      </xsl:otherwise>
    </xsl:choose>
  </div>

  <a href="perfiles.html">← Volver a perfiles</a>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
