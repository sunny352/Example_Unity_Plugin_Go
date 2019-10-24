using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class Main : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log(GetTimeString());
        Debug.Log(GetNativeValue());
        Debug.Log(GetPlatformValue());
    }

    #region NativePlugin
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern long GetNativeValue();
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern IntPtr GetTime();
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern void FreeStr(IntPtr str);
    
    private string GetTimeString()
    {
        var ptr = GetTime();
        var str = Marshal.PtrToStringAnsi(ptr);
        FreeStr(ptr);
        return str;
    }

    #endregion

    #region PlatformPlugin

#if UNITY_EDITOR
    private static long GetPlatformValue()
    {
        return 0;
    }
#else
#if UNITY_ANDROID
    private static long GetPlatformValue()
    {
        try
        {
            var unityPlugin = new AndroidJavaClass("PlatformPlugin.PlatformPlugin");
            return unityPlugin.CallStatic<long>("getPlatformValue");
        }
        catch (Exception e)
        {
            Debug.LogException(e);
            return 0;
        }
    }
#elif UNITY_IOS 
    [DllImport ("__Internal")]
    private static extern long PlatformPluginGetPlatformValue();
    private static long GetPlatformValue()
    {
        return PlatformPluginGetPlatformValue();
    }
#endif
#endif

    #endregion

    
}