using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Http;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Prefer APP_ENV (from Helm values), fallback to ASP.NET Core built-in environment
string GetEnv() =>
    System.Environment.GetEnvironmentVariable("APP_ENV")
    ?? builder.Environment.EnvironmentName;

(string bgColor, string envEmoji) EnvStyle(string env) => env.ToLower() switch
{
    "dev"         => ("#8e44ad", "💻"),
    "qa"          => ("#f39c12", "🧪"),
    "uat"         => ("#2980b9", "🔧"),
    "prod"        => ("#27ae60", "🏭"),
    "development" => ("#8e44ad", "💻"),
    "staging"     => ("#f39c12", "🧪"),
    "production"  => ("#27ae60", "🏭"),
    _             => ("#7f8c8d", "❓")
};

string Page(string title, string emoji, string message)
{
    var env = GetEnv();
    var (bgColor, envEmoji) = EnvStyle(env);

    return $@"
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset='UTF-8'>
        <title>{title}</title>
        <style>
            body {{
                font-family: 'Segoe UI', Arial, sans-serif;
                background: url('/images/raghavendrar.jpg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding-top: 120px;
            }}
            .header {{
                background: rgba(255,255,255,0.85);
                width: 100%;
                padding: 20px 0;
                text-align: center;
                box-shadow: 0px 4px 10px rgba(0,0,0,0.2);
                position: fixed;
                top: 0;
                left: 0;
            }}
            h1 {{
                margin: 5px 0;
                color: #2c3e50;
            }}
            .env {{
                font-weight: bold;
                font-size: 16px;
                color: {bgColor};
            }}
            nav {{
                margin-top: 10px;
            }}
            nav a {{
                margin: 0 10px;
                text-decoration: none;
                color: #2980b9;
                font-weight: bold;
            }}
            nav a:hover {{
                text-decoration: underline;
            }}
            .footer {{
                margin-top: 10px;
                font-size: 14px;
                color: #2c3e50;
            }}
        </style>
    </head>
    <body>
        <div class='header'>
            <h1>{emoji} {title}</h1>
            <p>{message}</p>
            <p class='env'>Environment: {envEmoji} {env.ToUpper()}</p>
            <nav>
                <a href='/'>Home</a> |
                <a href='/employee'>Employee</a> |
                <a href='/department'>Department</a> |
                <a href='/reports'>Reports</a>
            </nav>
            <div class='footer'>Made with ASP.NET Core</div>
        </div>
    </body>
    </html>";
}

app.MapGet("/", async context =>
{
    await context.Response.WriteAsync(Page("Home", "🏠", "Welcome to 20/05/2026 @ 01:47 PM"));
});

app.MapGet("/employee", async context =>
{
    await context.Response.WriteAsync(Page("Employee Module", "👤", "Manage employee profiles here"));
});

app.MapGet("/department", async context =>
{
    await context.Response.WriteAsync(Page("Department Module", "🏢", "View and manage departments"));
});

app.MapGet("/reports", async context =>
{
    await context.Response.WriteAsync(Page("Reports Module", "📊", "Generate and view reports"));
});

app.UseStaticFiles();
app.Run();