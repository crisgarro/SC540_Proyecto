using Backend.Settings;
using Microsoft.AspNetCore.Hosting.StaticWebAssets;
using MudBlazor.Services;
using System.Configuration;
using Backend;

var builder = WebApplication.CreateBuilder(args);

StaticWebAssetsLoader.UseStaticWebAssets(builder.Environment, builder.Configuration);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddMudServices();

//Register of Logging
builder.Logging.AddConfiguration(builder.Configuration.GetSection("Logging"));

//Register of Setttings used in Database
builder.Services.Configure<OracleConnectionSettings>(builder.Configuration.GetSection(nameof(OracleConnectionSettings)));
builder.Services.AddScoped<OracleConnectionManager>();

//Register Services
//builder.Services.AddSingleton<WeatherForecastService>();
//builder.Services.AddSingleton<OracleConnectionSettings>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();